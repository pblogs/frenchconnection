class UserTask < ActiveRecord::Base
  belongs_to :user
  belongs_to :task
  has_many :hours_spents, -> (user_task) { where(user_id: user_task.user_id) }, through: :task

  symbolize :status, in: %i(pending complete), default: :pending

  def complete!
    update_attribute(:status, :complete)
  end

end
