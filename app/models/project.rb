# == Schema Information
#
# Table name: projects
#
#  id                                   :integer          not null, primary key
#  project_number                       :string(255)
#  name                                 :string(255)
#  created_at                           :datetime
#  updated_at                           :datetime
#  customer_id                          :integer
#  start_date                           :date
#  due_date                             :date
#  description                          :text
#  user_id                              :integer
#  execution_address                    :string(255)
#  customer_reference                   :text
#  comment                              :text
#  sms_employee_if_hours_not_registered :boolean          default(FALSE)
#  sms_employee_when_new_task_created   :boolean          default(FALSE)
#  department_id                        :integer
#  short_description                    :string(255)
#  complete                             :boolean          default(FALSE)
#

class Project < ActiveRecord::Base
  include Favorable

  has_many :tasks
  has_many :user_tasks,   :through => :tasks
  has_many :attachments
  has_many :hours_spents, :through => :tasks
  has_many :users,        :through => :tasks

  belongs_to :customer
  belongs_to :user
  belongs_to :department
  has_many :favorites, as: :favorable

  validates :customer_id,       :presence => true
  validates :start_date,        :presence => true
  validates :department_id,     :presence => true
  validates :project_number,    :presence => true
  validates :name,              :presence => true

  attr_accessor :single_task

  scope :active,    -> { where(complete: false) }
  scope :complete,  -> { where(complete: true)  }

  def task_drafts
    tasks.where(draft: true)
  end

  def single_task?
    single_task == '1'
  end

  def professions
    professions = []
    users.each { |u| professions << u.profession }
    professions.uniq
  end

  def users_with_profession(profession:)
    users.where(profession_id: profession.id)
  end

  def generate_monthly_report(year, month, overtime)
    starting_date, ending_date, total_weeks = get_month_metadata(year.to_i, month.to_i)
    project_hours = initialize_project_hours(total_weeks)
    project_hours = calculate_hours(project_hours, starting_date: starting_date,
                                    ending_date: ending_date, 
                                    total_weeks: total_weeks, overtime: overtime)
    [project_hours, total_weeks.count]
  end

  def hours_spent_for_profession(profession, overtime:)
    users = users_with_profession(profession: profession)
    all_kinds_of_hours = users.collect { |u| hours_spents.where(user: u ).to_a }.flatten
    all = all_kinds_of_hours.select { |h| h.send(overtime) > 0 rescue nil }
    all.select { |h| h.send(overtime).present? }
  end

  def hours_spent_total(profession: nil,  overtime: )
    users = profession ? users_with_profession(profession: profession) : self.users
    sum = 0
    users.each { |u| sum += hours_total_for(u, overtime: overtime) rescue 0} 
    sum
  end

  # Used by /projects/:id/hours
  # Sums all hours for each user for the given month
  def hours_for_all_users(month_nr: nil, year: nil)
    require 'ostruct'
    sum = []
    if month_nr && year
      users.each do |u|
        sum_hours_for_user(user: u, month_nr: month_nr, year: year)
        user = build_sum_for_user(u)
        sum << user unless user.blank?
      end
    else
      users.each do |u|
        sum_hours_for_user_total(user: u)
        user = build_sum_for_user(u)
        sum << user unless user.blank?
      end
    end
    sum
    #binding.pry
  end

  def hours_total_for(user, overtime: nil)
    sum = 0
    # Summer approved og billable
    #binding.pry
    if overtime
      sum += hours_spents.where(user: user).billable.sum(overtime)
      sum += hours_spents.where(user: user).approved.sum(overtime)
    else
      HoursSpent::TYPES.each do |type|
        sum += hours_spents.where(user: user).billable.sum(type)
        sum += hours_spents.where(user: user).approved.sum(type)
      end
    end
    sum ? sum : 0
  end

  def name_of_users(profession: nil)
    return unless users
    if profession
      u = users_with_profession(profession: profession)
      u.each.collect {|user| user.name}.join(', ')
    else
      users.each.collect {|user| user.name}.join(', ')
    end
  end

  def address
    execution_address || customer.address
  end

  def week_numbers(profession: nil, overtime: nil)
    if profession
      dates = users_with_profession(profession: profession)
        .each.collect {|u| u.hours_spents.pluck(:date) }.flatten
      week_numbers = dates.collect {|d| d.cweek }
    else
      week_numbers = hours_spents.collect { |h| h.date.to_datetime.cweek }
    end
    week_numbers.uniq.sort.join(', ')
  end

  def complete!
    update_attribute(:complete, true)
  end

  # Returns tasks where one or more user_tasks is not complete
  def find_task_by_status(status)
    ids = user_tasks.where(status: status).pluck(:task_id).uniq
    Task.find([ids]).all || nil
  end

  # create methods on the fly for accessing last zipped reports
  # of different types, e.g. last_timesheet, last_daily_report
  ZippedReport.report_type_enum.each do |t|
    define_method "last_#{t.last}" do
      ZippedReport.where(report_type: t.last).order(:created_at).last
    end
  end

  def tasks_in_progress
    tasks.select { |t| t.in_progress? }
  end

  def completed_tasks
    tasks.select { |t| t.complete? }
  end

  def build_single_task
    tasks.build do |t|
      t.customer_id = customer_id
      t.description = description
      t.start_date = start_date
      t.due_date = due_date
    end
  end

  private

    def get_month_metadata(year, month)
      starting_date = Date.new(year, month, 1)
      ending_date = starting_date.end_of_month
      total_weeks = ((starting_date.cweek)..(ending_date.cweek)).to_a
      [starting_date, ending_date, total_weeks]
    end

    def calculate_hours(project_hours, opts = {})
      populate_hours(project_hours, starting_date: opts[:starting_date], 
                     ending_date: opts[:ending_date],
                     total_weeks: opts[:total_weeks], overtime: opts[:overtime])
      reorder_hash(project_hours)
      populate_sum(project_hours)
    end

    def initialize_project_hours(total_weeks, project_hours = {})
      project_hours[name] ||= {}
      total_weeks.each { |week_no| project_hours[name][week_no] ||= 0 }
      project_hours[name][:sum] = 0
      project_hours
    end

    def populate_hours(project_hours, opts = {})
      hours_spents.where(date: opts[:starting_date]..opts[:ending_date]).order(:date).each do |hour_spent|
        project_hours[hour_spent.profession_department] ||= {}
        opts[:total_weeks].each { |week_no| project_hours[hour_spent.profession_department][week_no] ||= 0 }
        project_hours[hour_spent.profession_department][:sum] ||= 0
        project_hours[hour_spent.profession_department][hour_spent.date.cweek] += hour_spent.send(opts[:overtime]) rescue nil
        project_hours[name][hour_spent.date.cweek] += hour_spent.send(opts[:overtime]) rescue nil
      end
    end

    def populate_sum(project_hours)
      project_hours.each do |key, value|
        project_hours[key].each do |k,v|
          project_hours[key][:sum] += v unless k == :sum
        end
      end
    end

    def sum_hours_for_user(user:, month_nr:, year:)
      m = month_nr; y = year; u = user
      @hour           = hours_spents.year(y).month(m).where(user: u).sum(:hour)
      @overtime_50    = hours_spents.year(y).month(m).where(user: u).sum(:overtime_50)
      @overtime_100   = hours_spents.year(y).month(m).where(user: u).sum(:overtime_100)
      @runs_in_company_car = hours_spents.month(m).where(user: u)
        .sum(:runs_in_company_car)
      @km_driven_own_car = hours_spents.month(m).where(user: u)
        .sum(:km_driven_own_car)
      @toll_expenses_own_car = hours_spents.month(m).where(user: u)
        .sum(:toll_expenses_own_car)
      @approved = hours_spents.month(m).year(y).where(user: u).not_approved.exists?
    end
    
    def sum_hours_for_user_total(user:)
      u = user
      @hour           = hours_spents.where(user: u).sum(:hour)
      @overtime_50    = hours_spents.where(user: u).sum(:overtime_50)
      @overtime_100   = hours_spents.where(user: u).sum(:overtime_100)
      @runs_in_company_car = hours_spents.where(user: u).sum(:runs_in_company_car)
      @km_driven_own_car = hours_spents.where(user: u).sum(:km_driven_own_car)
      @toll_expenses_own_car = hours_spents.where(user: u)
        .sum(:toll_expenses_own_car)
      @approved = hours_spents.where(user: u).not_approved.exists?
    end

    def build_sum_for_user(u)
      user = OpenStruct.new
      user.user                  = u
      user.hour                  = @hour
      user.overtime_50           = @overtime_50
      user.overtime_100          = @overtime_100
      user.runs_in_company_car   = @runs_in_company_car
      user.km_driven_own_car     = @km_driven_own_car
      user.toll_expenses_own_car = @toll_expenses_own_car
      user.approved              = @approved
      return user if @hour > 0 ||
        @overtime_50  > 0||
        @overtime_100  > 0||
        @runs_in_company_car > 0 ||
        @km_driven_own_car > 0 ||
        @toll_expenses_own_car > 0
    end

    def reorder_hash(project_hours)
      sum_hash = project_hours[name]
      project_hours.delete(name)
      project_hours[name] = sum_hash
    end
end
