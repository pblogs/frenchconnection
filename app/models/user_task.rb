# == Schema Information
#
# Table name: user_tasks
#
#  id         :integer          not null, primary key
#  user_id    :integer          not null
#  task_id    :integer          not null
#  status     :string(255)      not null
#  created_at :datetime
#  updated_at :datetime
#

class UserTask < ActiveRecord::Base
  belongs_to :user
  belongs_to :task
  has_many :hours_spents, -> (user_task) { where(user_id: user_task.user_id) },
    through: :task

  symbolize :status, in: %i(pending confirmed complete), default: :pending

  after_create :notify_worker, if: :sms_employee_when_new_task_created

  def notify_worker
    return if task.draft
    msg = I18n.t('sms.new_task', link: "http://allieroapp.orwapp.com")
    Rails.logger.debug "\n Notify worker: #{user.name}"
    Sms.send_msg(to: "47#{user.mobile}", msg: msg)
  end

  def sms_employee_when_new_task_created
    if task.project.present?
      Rails.logger.debug "\n sms_employee_when_new_task_created set?:"+
        "#{task.project.sms_employee_when_new_task_created}\n"
      task.project.sms_employee_when_new_task_created
    else
      false
    end
  end

  def confirm!
    update_attribute(:status, :confirmed)
  end

  def complete!
    update_attribute(:status, :complete)
  end

  def complete?
    status == :complete
  end

end
