$ ->
  $(document).on 'click', '.accordion.top-left li', (e) ->
    # Toggle active link
    $('.accordion.top-left li').removeClass('active')
    $(this).addClass('active')

    # Hide all sections and open the selected
    $('content.main div').hide()
    to_show = $(this).data('toShow')
    console.log "its .#{to_show}"
    $(".#{to_show}").show()

    #$('.skills').toggle()
    #$('.certificates').toggle()
    #$('.hms-skills').addClass('active')
    #$('.hms-certificates').removeClass('active')

  #$(document).on 'click', '.hms-certificates', (e) ->
  #  $('.skills').toggle()
  #  $('.certificates').toggle()
  #  $('.hms-certificates').addClass('active')
  #  $('.hms-skills').removeClass('active')
