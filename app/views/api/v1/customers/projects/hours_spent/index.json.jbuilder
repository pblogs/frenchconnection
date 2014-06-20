json.array!(@hours_spents) do |hours_spent|
  json.extract! hours_spent, :id, :customer_id, :task_id, :hour
  json.url hours_spent_url(hours_spent, format: :json)
end
