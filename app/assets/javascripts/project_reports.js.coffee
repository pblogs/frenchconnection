app.registerPusherListener = (userId, token) ->

  channel = app.pusher.subscribe("user-#{userId}")
  channel.bind "report", (data) ->
    if data.token == token
      $(".success-message").show()
      $(".report-link").attr('href', data.url)
      $(".wait-message").hide()
    return
