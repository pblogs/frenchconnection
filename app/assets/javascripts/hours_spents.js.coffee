$(document).on 'ready page:load', ->
  $("#hours_spent_runs_in_company_car").blur ->
    val = field = $('#hours_spent_runs_in_company_car').val()
    if val > 0
      $('#drives_his_own_car').hide()
    else
      $('#drives_his_own_car').show()

$(document).on 'click', '.month-list > label', (e) ->
  e.preventDefault()
  month = $(this).find('input').val()
  $('select#date_month').val(month)
  $('form#time').submit()
