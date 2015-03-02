$ ->
  $(document).on 'click', '.accordion.top-left li', (e) ->
    # Toggle active link
    $('.accordion.top-left li').removeClass('active')
    $(this).addClass('active')

    # Hide all sections and open the selected
    $('content.main div').hide()
    to_show = $(this).data('toShow')
    $(".#{to_show}").show()
