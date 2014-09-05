class Change < ActiveRecord::Base
  belongs_to :hours_spent


  def self.create_from_hours_spent(hours_spent: hours_spent, 
                                   description: description)
    hours_spent_id = hours_spent.id
    c = Change.new(hours_spent.attributes.except(
      'customer_id',
      'id',
      'task_id',
      'date',
      'user_id',
      'project_id'
     )) 
    puts "description is #{description}"
    c.hours_spent_id = hours_spent.id
    c.description = description
    puts "c.description is #{c.description}"
    c
  end

end
