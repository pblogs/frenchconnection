class Task < ActiveRecord::Base
  belongs_to :customer
  belongs_to :task_type
end
