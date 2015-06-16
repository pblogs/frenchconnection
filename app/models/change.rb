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
#  supplies_from_warehouse :string
#  piecework_hours         :integer
#  overtime_50             :integer
#  overtime_100            :integer
#  hour                    :integer
#  text                    :string
#  reason                  :text
#  user_id                 :integer
#

class Change < ActiveRecord::Base
  belongs_to :hours_spent
  belongs_to :user
  validates :hours_spent,  presence: true
  validates :reason,  presence: true


end

