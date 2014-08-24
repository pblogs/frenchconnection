unless Rails.env.test?
  SMS = Clickatell::API.authenticate( ENV['CLICKATELL_API_ID'], ENV['CLICKATELL_USERNAME'], ENV['CLICKATELL_PASSWORD'] )
end
