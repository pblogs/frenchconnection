class UserTask < ActiveRecord::Base
  belongs_to :user
  belongs_to :task

  symbolize :status, in: %i(pending complete), default: :pending

  def complete!
    update_attribute(:status, :complete)
  end

end
