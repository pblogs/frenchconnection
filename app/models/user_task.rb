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
  has_many :hours_spents, -> (user_task) { where(user_id: user_task.user_id) }, through: :task

  symbolize :status, in: %i(pending confirmed complete), default: :pending

  def confirm!
    update_attribute(:status, :confirmed)
  end

  def complete!
    update_attribute(:status, :complete)
  end

end
