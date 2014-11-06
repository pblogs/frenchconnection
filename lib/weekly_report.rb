class WeeklyReport
  require 'rubygems'
  require 'axlsx'

  def initialize(project:, profession:, overtime: :hour)
    @project    = project
    @overtime   = overtime  # In percent. E.g: 50 or 100
    @workers    = @project.users
    @header     = "DAGSRAPPORT - #{@project.name} - #{@overtime}"
    @logo       = 'app/assets/images/alliero-bratfoss-h46.png'
  end

end
