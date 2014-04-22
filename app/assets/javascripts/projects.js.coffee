$(document).on 'click', '#payment_project_paid_by_the_hour', (e) ->
  $('.field.hour_rate').fadeIn()
  $('.field.price_total').fadeOut()
  

$(document).on 'click', '#payment_fixed_price', (e) ->
  $('.field.hour_rate').fadeOut()
  $('.field.price_total').fadeIn()
