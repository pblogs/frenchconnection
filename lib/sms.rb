class Sms
  def self.send_msg(to:, msg:, dryrun: false)
    @to = to
    @msg = msg
    if dryrun || (Rails.env.test? || Rails.env.development?)
      Rails.logger.debug  "NOT sending SMS\n to:#{ @to } msg:#{ @msg }"
    elsif valid_norwegian_number?(@to)
      Rails.logger.debug  "Sending SMS\n to:#{ @to } msg:#{ @msg }"
      Rails.logger.debug  Net::HTTP.get(URI.parse(self.url))
    end
  end

  private

  def self.valid_norwegian_number?(nr)
    nr.to_s.match(/^47[\d]{8}$/)
  end

  def self.encode_msg
    iso_str = Iconv.new('iso-8859-1', 'utf-8').iconv(@msg)
    CGI.escape(iso_str)
  end


  def self.url
    "http://bulksms.vsms.net:5567/eapi/submission/send_sms/2/2.0?" +
    "username=#{ENV['BULKSMS_USERNAME']}" +
    "&password=#{ENV['BULKSMS_PASSWORD']}&sender=Orwapp" +
    "&allow_concat_text_sms=1&concat_text_sms_max_parts=8" +
    "&want_report=8&message=#{encode_msg}&msisdn=#{@to}"
  end

end
