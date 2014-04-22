module ProjectsHelper

  def payment(project)
    if project.paid_by_the_hour
      content_tag(:strong) do
        content_tag(:span) do
          "Pris pr time: #{project.hour_rate}"
        end
      end
    elsif project.fixed_price
      content_tag(:strong) do
        content_tag(:span) do
          "Fastpris #{project.price_total}"
        end
      end
    end


  end
end
