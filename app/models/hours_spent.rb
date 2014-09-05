class HoursSpent < ActiveRecord::Base
  belongs_to :user
  belongs_to :task
  belongs_to :project
  has_one :change

  validates :task,        :presence => true
  validates :user,        :presence => true
  validates :description, :presence => true
  validates :date,        :presence => true
  validates :project_id,     :presence => true

  def sum
    (self.hour            ||  0) +
    (self.piecework_hours ||  0) +
    (self.overtime_50     ||  0) +
    (self.overtime_100    ||  0)  
  end

  def method_missing(m, *args, &block)
    if m.to_s.match /changed_value_/
      value = m.to_s.gsub('changed_value_', '')
      puts "will query for #{value}"
      puts "change is #{change.inspect}"
      puts "My id is #{id}"
      #change.send(value) ? change.send(value) : self.send(value)
      change.try(value) || send(value)
    else
      super
    end
  end

end

    #raise "return value from #{m}"
    # str = "Called #{m} with #{args.inspect}"
    # if block_given?
    #   puts str + " and also a block: #{block}"
    # else
    #   puts str
    # end
