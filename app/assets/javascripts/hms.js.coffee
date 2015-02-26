$ ->
  $(document).on 'click', '.hms-skills', (e) ->
    $('.skills').toggle()
    $('.certificates').toggle()
    $('.hms-skills').addClass('active')
    $('.hms-certificates').removeClass('active')

  $(document).on 'click', '.hms-certificates', (e) ->
    $('.skills').toggle()
    $('.certificates').toggle()
    console.log this
    $('.hms-certificates').addClass('active')
    $('.hms-skills').removeClass('active')
