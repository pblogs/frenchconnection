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
#  of_kind                 :string(255)      default("personal")
#  billable_id             :integer
#  personal_id             :integer
#  approved                :boolean          default(FALSE)
#  change_reason           :text
#  old_values              :text
#  edited_by_admin         :boolean          default(FALSE)
#

# When a user registers hours on a task, it's generates 2 HoursSpent.
# One personal and one billable. Never spesify of_kind when creating a new one,
# personal and billable will be created automatically.
#
# Workers nor admins can not edit hours after they have been approved.
#
# == Generating reports
# The hours within the selected scope is set as approved when
# daily_report or timesheet is generated. An approved hour can not be changed.
#
#
class HoursSpent < ActiveRecord::Base
  TYPES = %w(hour piecework_hours overtime_50 overtime_100)
  belongs_to :user
  belongs_to :task
  belongs_to :project
  has_one :change

  validates :task,          :presence => true
  validates :user,          :presence => true
  validates :description,   :presence => true
  validates :date,          :presence => true
  validates :project_id,    :presence => true

  symbolize :of_kind, in: %i(personal billable), default: :personal
  serialize :old_values

  scope :for_user_on_project, ->(user, project) {
    where(user_id: user.id, project_id: project.id) }

  scope :for_user_on_task, ->(user_id, task_id) {
    where("user_id = ? AND task_id = ?", user_id, task_id) }

  scope :year,     ->(year)  { where('extract(year  from date) = ?',  year) }
  scope :month,    ->(month) { where('extract(month from date) = ?',  month) }
  scope :personal, -> { where(of_kind: 'personal') }
  scope :billable, -> { where(of_kind: 'billable') }
  scope :of_kind,   ->(kind) { where('of_kind = ?', kind) }
  scope :approved, -> { where(approved: true) }
  scope :edited_by_admin,     -> { where(edited_by_admin: true) }
  scope :not_edited_by_admin, -> { where(edited_by_admin: false) }
  scope :not_approved,        -> { where(approved: false) }

  after_create :create_billable

  # Sums all the different types of hours registered
  # for one day, on one user.
  def sum(overtime: nil)
    (self.hour            ||  0) +
      (self.piecework_hours ||  0) +
      (self.overtime_50     ||  0) +
      (self.overtime_100    ||  0)
  end

  def billable?
    of_kind == :billable
  end

  def personal?
    of_kind == :personal
  end

  def approve!
    self.update_attributes(approved: true)
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

  private

  def create_billable
    return if billable?
    HoursSpent.create!(self.attributes
      .merge(of_kind: :billable)
      .except('id', 'created_at', 'updated_at'))
  end
end
