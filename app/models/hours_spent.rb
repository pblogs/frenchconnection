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

# When a user registers hours on a task, it's registered as personal hours.
# The project leader can list these hours pr month on each project.
# If the project leader wants to approve or change anything, he needs to press 
# freeze hours. This will make a billabel copy of the personal hours.
#
# The 'Approve hours' and edit options will be available after 'freeze hours' is clicked.
# The personal hours in this scope will ba marked as frozen. 
#
# Meaning that when listing hours for project 1 in january, it will not 
# display personal hours that's frozen, only billable hours. 
# If a user register more hours for january after they has been frozen by the project leader,
# then they will be listed above the billable as new. 
#
# Example of hours listed for project/1/month/1/year/2015
#  @new_hours = @project.hours_spent.personal.not_frozen.year(2015).month(1)
#  @billable_approved_hours = @project.hours_spent.billable.approved.year(2015).month(1)
#  @billable_not_approved_hours = @project.hours_spent.billable.not_approved.year(2015).month(1)
#
# Billable hours that is not approved, will be highlighted. 
# These will not be used in calculations when generating reports.
# Any change the project leader makes to these hours will be on the billable version. 
# PDF reports generated will use the billable and approved hours.
# 
class HoursSpent < ActiveRecord::Base
  TYPES = %w(hour piecework_hours overtime_50 overtime_100)
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
  serialize :old_values

  scope :for_user_on_project, ->(user, project) { 
    where(user_id: user.id, project_id: project.id) }

  scope :for_user_on_task, ->(user_id, task_id) { 
    where(user_id: user_id, task_id: task_id) }

  scope :year,       ->(year)  { where('extract(year  from date) = ?',  year) }
  scope :month,      ->(month) { where('extract(month from date) = ?',  month) }
  scope :personal,   -> { where(of_kind: 'personal') } 
  scope :billable,   -> { where(of_kind: 'billable') } 
  scope :approved,   -> { where(approved: true) } 
  scope :not_approved,   -> { where(approved: false) } 
  scope :frozen_by_admin, -> { where(frozen_by_admin: true) } 
  scope :not_frozen_by_admin, -> { where(frozen_by_admin: false) } 

  # Sums all the different types of hours registered
  # for one day, on one user.
  def sum(overtime: nil)
    (self.hour            ||  0) +
      (self.piecework_hours ||  0) +
      (self.overtime_50     ||  0) +
      (self.overtime_100    ||  0)
  end

  def billable?
    self.of_kind == :billable
  end

  def personal?
    self.of_kind == :personal
  end

  def approve!
    update_attributes(approved: true, frozen_by_admin: true)
  end

  def requires_approval?
    personal? && !frozen_by_admin
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
