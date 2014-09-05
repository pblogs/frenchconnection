Fabricator(:change) do
  description        "sov på jobb"
  hours_spent_id         { Fabricate(:hours_spent).id }
  changed_by_user_id { Fabricate(:user).id }
end
