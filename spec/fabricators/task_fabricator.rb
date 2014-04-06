Fabricator(:task) do
  customer               { Fabricate(:customer) }
  task_type              { Fabricate(:task_type) }
  start_date             "2014-04-06 10:55:29"
  customer_buys_supplies false
end
