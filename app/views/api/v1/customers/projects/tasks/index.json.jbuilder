json.array!(@tasks) do |task|
  json.extract! task, :id, :customer_id, :task_type_id, :start_date, :customer_buys_supplies
  json.url task_url(task, format: :json)
end
