class ExcelProjectTools

  # Returns an array with nr of hours
  def self.hours_for_users(project:, profession:,  overtime:, of_kind:)
    hours = []
    project.users.where(profession: profession).each do |user|
      hours_spent = []
      hours_spent << project.hours_spents.approved.where(user: user,
        of_kind: of_kind).all
      hours_spent.flatten!
      hours << hours_spent.map { |hs| hs.send(overtime) }
    end
    hours.flatten!
    hours.map {|x| "#{x}" }
  end

  def self.user_names(project:, profession_title:)
    profession = Profession.where(title: profession_title).first
    project.name_of_users(profession: profession).split(',').flatten
  end

  def self.sum_piecework_hours(project:, user:, of_kind:)
    HoursSpent.approved.where(user: user, project: project, of_kind: of_kind)
      .sum(:piecework_hours)
  end

  def self.sum_workhours(project:, user:, of_kind:)
    HoursSpent.approved.where(user: user, project: project, of_kind: of_kind)
      .sum(:hour)
  end

  def self.sum_overtime_50(project:, user:, of_kind:)
    HoursSpent.approved.where(user: user, project: project, of_kind: of_kind)
      .sum(:overtime_50)
  end

  def self.sum_overtime_100(project:, user:, of_kind:)
    HoursSpent.approved.where(user: user, project: project, of_kind: of_kind)
      .sum(:overtime_100)
  end


end
