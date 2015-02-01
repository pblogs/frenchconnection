# == Schema Information
#
# Table name: changes
#
#  id                      :integer          not null, primary key
#  description             :text
#  hours_spent_id          :integer
#  changed_by_user_id      :integer
#  created_at              :datetime
#  updated_at              :datetime
#  runs_in_company_car     :integer
#  km_driven_own_car       :float
#  toll_expenses_own_car   :float
#  supplies_from_warehouse :string(255)
#  piecework_hours         :integer
#  overtime_50             :integer
#  overtime_100            :integer
#  hour                    :integer
#  text                    :string(255)
#  reason                  :text
#

class Change < ActiveRecord::Base
  belongs_to :hours_spent
  validates :hours_spent,  presence: true


  def self.create_from_hours_spent(hours_spent: hours_spent, reason: reason)
    c = Change.new(hours_spent.attributes.except(
      'customer_id',
      'id',
      'task_id',
      'date',
      'user_id',
      'kind_of',
      'project_id'
    ))
    c.hours_spent_id = hours_spent.id
    c.reason = reason
    c
  end

end

