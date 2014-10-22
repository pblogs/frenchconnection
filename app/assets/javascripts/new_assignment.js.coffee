$ ->
  # Go the the new task for company page on click.
  $(document).on 'click', '.new_project_on_company', (e) ->
    company_id = $("#customer option:selected").val()
    this.href = "/customers/#{company_id}/projects/new"
