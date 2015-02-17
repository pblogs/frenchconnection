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
#  address          :string(255)
#

class Task < ActiveRecord::Base

  belongs_to :project
  belongs_to :location
  has_and_belongs_to_many :skills
  has_many :user_tasks
  has_many :users, through: :user_tasks
  has_many :hours_spents
  has_many :mobile_pictures
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

  def active?
    ended_at.blank? && finished == false ||
    project.complete?
  end

  def hours_total(of_kind:)
    self.hours_spents.send(of_kind).sum(:hour) +
    self.hours_spents.send(of_kind).sum(:piecework_hours) +
    self.hours_spents.send(of_kind).sum(:overtime_50) +
    self.hours_spents.send(of_kind).sum(:overtime_100)
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
      User.with_role(:worker) - self.users
    end
  end

  def save_and_order_resources!
    self.draft = false
    self.save
    notify_workers
    # Order resources
  end

  private

  def notify_workers
    user_tasks.each { |t| t.notify_worker }
  end

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
