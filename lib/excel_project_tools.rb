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
    # TODO Remove sourrunding whitespace
  end

end
