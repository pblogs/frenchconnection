# == Schema Information
#
# Table name: tasks
#
#  id                     :integer          not null, primary key
#  customer_id            :integer
#  task_type_id           :integer
#  start_date             :date
#  customer_buys_supplies :boolean
#  created_at             :datetime
#  updated_at             :datetime
#  paint_id               :integer
#  accepted               :boolean
#  description            :string(255)
#  finished               :boolean          default(FALSE)
#  project_id             :integer
#  due_date               :date
#

class Task < ActiveRecord::Base

  belongs_to :project
  belongs_to :paint
  has_many :user_tasks
  has_many :users, through: :user_tasks

  has_many :hours_spents

  validates :project_id, :presence => true, :unless => :single_task
  validates :start_date, :presence => true

  validate :start_date_must_be_within_projects_dates_range, 
    if: Proc.new { |p| p.start_date.present? }
  validate :due_date_must_be_within_projects_dates_range

  attr_accessor :department_id

  after_create :notify_workers, if: :sms_employee_when_new_task_created

  def sms_employee_when_new_task_created
    project.sms_employee_when_new_task_created
  end

  def hours_total
    self.hours_spents.sum(:hour) +
    self.hours_spents.sum(:piecework_hours) +
    self.hours_spents.sum(:overtime_50) +
    self.hours_spents.sum(:overtime_100)
  end

  def name_of_users
    users.pluck(:first_name).join(', ' )
  end

  private

  def notify_workers
    domain = "#{ ENV['DOMAIN'] || 'allieroforms.dev' }"
    msg = "Du har fått tildelt en ny oppgave. Les mer: "+ "http://#{domain}/tasks/#{id}"
    users.each do |u|
      Sms.send_msg(to: "47#{u.mobile}", msg: msg)
    end
  end

  def single_task
    project.single_task?
  end

  def start_date_must_be_within_projects_dates_range
    if (start_date < project.start_date  || start_date > project.due_date rescue nil )
      errors.add(:start_date, "must be within projects start_date and projects due_date")
    end
  end

  def due_date_must_be_within_projects_dates_range
    if due_date.present? && !((project.start_date)..(project.due_date)).include?(due_date)
      errors.add(:due_date, "must be within projects start_date and projects due_date")
    end
  end


end
