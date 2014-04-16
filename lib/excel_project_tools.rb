class ExcelProjectTools

  def self.hours_for_artisans(project)
    hours = []
    puts "\n\n\n project.artisans: #{project.class} \n\n\n"
    project.artisans.each do |a|
      hours << project.hours_total_for(a)
    end
    #hours
    hours.map {|x| "#{x}" }
  end

end
