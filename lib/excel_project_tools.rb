class ExcelProjectTools

  def self.hours_for_users(project)
    hours = []
    project.users.each do |a|
      hours << project.hours_total_for(a)
    end
    hours.map {|x| "#{x}" }
  end

  def self.user_names(project:, profession: nil)
    project.name_of_users(profession: profession).split(',')
  end

  def self.sum_piecework_hours(project: project, user: user)
    HoursSpent.where(user: user, project: project).sum(:piecework_hours)
  end

  def self.sum_workhours(project: project, user: user)
    HoursSpent.where(user: user, project: project).sum(:hour)
  end

  def self.sum_overtime_50(project: project, user: user)
    HoursSpent.where(user: user, project: project).sum(:overtime_50)
  end

  def self.sum_overtime_100(project: project, user: user)
    HoursSpent.where(user: user, project: project).sum(:overtime_100)
  end


end
