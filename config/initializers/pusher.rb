require 'pusher'

if ENV['PUSHER_URL'].present?
  Pusher.url = ENV['PUSHER_URL']
  Pusher.logger = Rails.logger

  Pusher['test_channel'].trigger('my_event', {
      message: 'hello world'
  })
end
