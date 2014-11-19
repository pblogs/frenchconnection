class HseController < ApplicationController

  def redirect
    response = RestClient.post "#{hse_url}/auth", user_id: current_user.id
    token = response.to_str
    logger.error token
    cookies[:hse_token] = { # TODO signed
        expires: 15.minutes.from_now,
        value: token,
        domain: Rails.env.production? ? domain : nil,
        httponly: true
    }
    redirect_to "#{hse_url}/auth"
  end

  private

  def hse_url
    ENV["HSE_URL"]
  end

  def domain
    ENV["DOMAIN"].split('.')[1..-1].join('.')
  end

end
