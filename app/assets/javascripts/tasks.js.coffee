# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  $(document).ready()
  $( ".datepicker" ).datepicker( { dateFormat: 'dd-mm-yy' } )

$ ->
  # Go the the new task for company page on click.
  $(document).on 'click', '.new_task_on_company', (e) ->
    company_id = $("#customer option:selected").val();
    this.href = "/customers/#{company_id}/tasks/new"

