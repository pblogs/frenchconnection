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
#  supplies_from_warehouse :string
#  of_kind                 :string           default("personal")
#  billable_id             :integer
#  personal_id             :integer
#  approved                :boolean          default(FALSE)
#  change_reason           :text
#  old_values              :text
#  edited_by_admin         :boolean          default(FALSE)
#

Fabricator(:hours_spent) do
  hour     0
  description 'Malt hus'
  date        { Time.now }
  task        { Fabricate(:task) }
  project     { Fabricate(:project) }
  user        { Fabricate(:user) }
  approved    false
  of_kind :personal
end
