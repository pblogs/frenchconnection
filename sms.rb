require 'rubygems'
require 'clickatell'

api = Clickatell::API.authenticate('3494167', 'orwapp_alliero', 'PPIKCMYONgdcZS')
api.send_message('4793441707', 'Hello from ruby scrupt')


#http://api.clickatell.com/http/sendmsg?user=orwapp_alliero&password=PPIKCMYONgdcZS&api_id=3494167&to=4793441707&text=Message
