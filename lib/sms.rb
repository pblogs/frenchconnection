class Sms
  def self.send_msg(to:, msg:)
    @to = to
    @msg = msg
    if Rails.env.development?
      puts "Sending SMS\n to:#{ @to } msg:#{ @msg }"
    else
      puts Net::HTTP.get(URI.parse(self.url))
    end
  end


  def self.encode_msg
    iso_str = Iconv.new('iso-8859-1', 'utf-8').iconv(@msg)
    CGI.escape(iso_str)
  end


  def self.url
    "http://bulksms.vsms.net:5567/eapi/submission/send_sms/2/2.0?" + 
    "username=#{ ENV['BULKSMS_USERNAME'] }" +
    "&password=#{ ENV['BULKSMS_PASSWORD'] }&sender=Orwapp" +
    "&allow_concat_text_sms=1&concat_text_sms_max_parts=8" +
    "&want_report=8&message=#{ encode_msg }&msisdn=#{ @to }"
  end

end
