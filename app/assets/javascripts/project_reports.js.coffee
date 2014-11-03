app.registerPusherListener = (userId, token) ->
  console.log 'yo dawg', userId, token

  channel = app.pusher.subscribe("user-#{userId}")
  channel.bind "report", (data) ->
    console.log data
    if data.token == token
      $(".success-message").show()
      $(".report-link").attr('href', data.url)
      $(".wait-message").hide()
    return
