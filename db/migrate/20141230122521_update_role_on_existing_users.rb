class UpdateRoleOnExistingUsers < ActiveRecord::Migration
  def change

    # Project leaders
    leaders = User.all.select { |u| u.roles.to_s.match 'project_leader' }
    leaders.each do |u| 
      u.roles = ['project_leader']
      u.save
    end

    # Workers
    workers = User.all.select { |u| u.roles.to_s.match 'worker' }
    workers.each do |u| 
      u.roles = ['worker']
      u.save
    end
  end
end
