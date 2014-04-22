module ProjectsHelper

  def payment(project)
    if project.paid_by_the_hour
      raise 'her'
      content_tag(:p) do
        content_tag(:span) do
          "Pris pr time: #{project.price_pr_hour}"
        end
      end
    end
  end
end
