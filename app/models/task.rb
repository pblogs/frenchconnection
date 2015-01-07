# == Schema Information
#
# Table name: tasks
#
#  id               :integer          not null, primary key
#  customer_id      :integer
#  start_date       :date
#  created_at       :datetime
#  updated_at       :datetime
#  accepted         :boolean
#  description      :string(255)
#  finished         :boolean          default(FALSE)
#  project_id       :integer
#  due_date         :date
#  ended_at         :datetime
#  work_category_id :integer
#  location_id      :integer
#  profession_id    :integer
#  skills_ids       :integer
#  draft            :boolean          default(TRUE)
#

class Task < ActiveRecord::Base

  belongs_to :project
  belongs_to :location
  has_and_belongs_to_many :skills
  has_many :user_tasks
  has_many :users, through: :user_tasks
  has_many :hours_spents
  has_and_belongs_to_many :inventories

  scope :from_user, ->(user) { joins(:user_tasks)
                                .where('user_tasks.user_id = ?', user.id) }
  scope :by_status, ->(status) { joins(:user_tasks)
                                  .where('user_tasks.status = ?', status) }
  scope :ordered, -> { order('created_at DESC') }

  validates :project_id, :presence => true, :unless => :single_task
  validates :start_date, :presence => true
  validates :description, :presence => true

  validate :start_date_must_be_within_projects_dates_range, 
    if: Proc.new { |p| p.start_date.present? }
  validate :due_date_must_be_within_projects_dates_range,
    if: Proc.new { |p| p.due_date.present? }

  attr_accessor :department_id
  attr_accessor :goto_tools

  def hours_total
    self.hours_spents.sum(:hour) +
    self.hours_spents.sum(:piecework_hours) +
    self.hours_spents.sum(:overtime_50) +
    self.hours_spents.sum(:overtime_100)
  end

  def name_of_users
    users.pluck(:first_name).join(', ' )
  end

  def end_task(admin)
    notify_all_users_of_ending_task(admin)
    update_attributes(
      ended_at: Time.now, finished: true
    ) 
  end

  def end_task_hard
    end_tasks_for_all_users
  end

  def in_progress?
    return false if draft
    UserTask.where(task_id: id).all.any? { |t| t.status != :complete }
  end

  def complete?
    return false if draft
    UserTask.where(task_id: id).all.all? { |t| t.status == :complete }
  end

  def qualified_workers
    certificates = inventories.collect { |i| i.certificates.to_a }.flatten
    if certificates.present?
      workers = certificates.collect { |c| c.users }.flatten.uniq
      # Don't list workers that has already been selected.
      workers - self.users
    else
      User.workers - self.users
    end
  end

  def save_and_order_resources!
    self.draft = false
    self.save
    # Order resources
  end

  private

  #def sms_employee_when_new_task_created
  #  project.sms_employee_when_new_task_created
  #end

  #def notify_workers
  #  users.each do |u|
  #    project.sms_employee_when_new_task_created
  #  end
  #end

  #def notify_workers(workers: nil)
  #  msg = I18n.t('sms.new_task', link: "http://allieroapp.orwapp.com")
  #  workers ||= users
  #  workers.each do |u|
  #    Sms.send_msg(to: "47#{u.mobile}", msg: msg)
  #  end
  #end

  #def notify_new_workers
  #  new_workers = users - @old_workers
  #  notify_workers(workers: new_workers)
  #end

  #def remember_old_workers
  #  @old_workers = users.all
  #end

  def single_task
    project.try(:single_task?)
  end

  def start_date_must_be_within_projects_dates_range
    if (start_date < project.start_date ||
        start_date > project.due_date rescue nil)
      errors.add(:start_date,
                 'must be within projects start_date and projects due_date')
    end
  end

  def due_date_must_be_within_projects_dates_range
    if (due_date < project.start_date || due_date > project.due_date rescue nil)
      errors.add(:due_date,
                 'must be within projects start_date and projects due_date')
    end
  end

  def notify_all_users_of_ending_task(admin)
    users.each do |user| 
      Sms.send_msg(
        to: "47#{user.mobile}", 
        msg: I18n.t('task_ended_by_admin', 
                    description: description,
                    from: admin.name
                   )
      )
    end
  end

  def end_tasks_for_all_users
    UserTask.where(task_id: id).all.each do |t| 
      t.update_attribute(:status, :complete)
    end
  end
  
end
