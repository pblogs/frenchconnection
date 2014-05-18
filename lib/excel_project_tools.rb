class ExcelProjectTools

  def self.hours_for_artisans(project)
    hours = []
    project.artisans.each do |a|
      hours << project.hours_total_for(a)
    end
    hours.map {|x| "#{x}" }
  end

  def self.artisan_names(project)
    project.name_of_artisans.split(',')
  end

  def self.sum_piecework_hours(project: project, artisan: artisan)
    HoursSpent.where(artisan: artisan, project: project).sum(:piecework_hours)
  end

  def self.sum_workhours(project: project, artisan: artisan)
    HoursSpent.where(artisan: artisan, project: project).sum(:hour)
  end

  def self.sum_overtime_50(project: project, artisan: artisan)
    HoursSpent.where(artisan: artisan, project: project).sum(:overtime_50)
  end

  def self.sum_overtime_100(project: project, artisan: artisan)
    HoursSpent.where(artisan: artisan, project: project).sum(:overtime_100)
  end


end
