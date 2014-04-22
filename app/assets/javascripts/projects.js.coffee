$(document).ready ->
  
  $('#payment_paid_by_the_hour').click () ->
    $('.field.hour_rate').fadeIn()

  $('#payment_fixed_price').click () ->
    $('.field.hour_rate').fadeOut()
