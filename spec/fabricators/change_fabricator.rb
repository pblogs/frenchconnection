Fabricator(:change) do
  description        "sov på jobb"
  hours_spent { Fabricate(:hours_spent)}
  changed_by_user_id { Fabricate(:user).id }
end
