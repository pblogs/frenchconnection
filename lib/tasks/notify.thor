class Notify < Thor

  desc "missing_hours", "Notify users that has forgot to register hours"

  def missing_hours
    puts "Loading Rails environment..."
    require File.expand_path('config/environment.rb')

    users_to_notify.each do |u|
      puts "Notify user: #{u.name}"
      Sms.send_msg u.mobile, <<-eos
        It seems that you haven't registered hours in one or more of your tasks
      eos
    end
  end

  private

  def users_to_notify
    projects = Project.where(sms_employee_if_hours_not_registered: true, complete: false)
    projects.inject([]) do |users, project|
      project.user_tasks.each do |user_task|
        if user_task.hours_spents.where(date: Date.today).empty?
          users << user_task.user
        end
      end
      users
    end
  end
end
