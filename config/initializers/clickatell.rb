unless Rails.env.test?
  SMS = Clickatell::API.authenticate( '3494167', 'orwapp_alliero', 'WCZwJcL4mxKYD3e@' )
end
