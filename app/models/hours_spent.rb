# == Schema Information
#
# Table name: hours_spents
#
#  id                      :integer          not null, primary key
#  customer_id             :integer
#  task_id                 :integer
#  hour                    :integer
#  created_at              :datetime
#  updated_at              :datetime
#  date                    :date
#  description             :text
#  user_id                 :integer
#  piecework_hours         :integer
#  overtime_50             :integer
#  overtime_100            :integer
#  project_id              :integer
#  runs_in_company_car     :integer
#  km_driven_own_car       :float
#  toll_expenses_own_car   :float
#  supplies_from_warehouse :string(255)
#  changed_hour_id         :integer
#  change_reason           :string(255)
#  changed_by_user_id      :integer
#

# Billable hours is only visible and editable for project_leaders that owns
# that project. Billable hours is created when the project is 'closed'.
# When the project_leader clicks 'approved', then the billable hours's approved
# attribute is set as true.
#
# The worker is not able to update HoursSpent when the project is 'closed'
#
# Personal hours is only visible and editable for users that belong to that 
# task, when the project is still active.
# 
class HoursSpent < ActiveRecord::Base
  belongs_to :user
  belongs_to :task
  belongs_to :project
  has_one :change

  validates :task,        :presence => true
  validates :user,        :presence => true
  validates :description, :presence => true
  validates :date,        :presence => true
  validates :project_id,  :presence => true

  symbolize :of_kind, in: %i(personal billable), default: :personal

  scope :for_user_on_project, ->(user, project) { 
    where(user_id: user.id, project_id: project.id) }

  scope :for_user_on_task, ->(user_id, task_id) { 
    where(user_id: user_id, task_id: task_id) }

  scope :year,     ->(year)  { where('extract(year  from date) = ?',  year) }
  scope :month,    ->(month) { where('extract(month from date) = ?',  month) }
  scope :personal, -> { where(of_kind: 'personal') } 
  scope :billable, -> { where(of_kind: 'billable') } 
  scope :find_billable, ->(hour_id) { billable.where(personal_id: hour_id) }
  scope :find_personal, ->(hour_id) { personal.where(billable_id: hour_id) }

  # Sums all the different types of hours registered
  # for one day, on one user.
  def sum(overtime: nil)
    (self.hour            ||  0) +
      (self.piecework_hours ||  0) +
      (self.overtime_50     ||  0) +
      (self.overtime_100    ||  0)
  end


  # TODO  Move into a date helper
  def self.week_numbers_for_dates(dates)
    dates.collect { |d| d.cweek }.sort.uniq.join(', ')
  end

  def self.week_numbers(hours_spents)
    dates = hours_spents.collect { |hs| hs.date }
    week_numbers_for_dates(dates)
  end

  def profession_department
    "#{user.profession.title}_#{user.department.title}"
  end
end
