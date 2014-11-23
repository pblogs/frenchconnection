class HseController < ApplicationController

  def redirect
    response = RestClient.post "#{hse_url}/auth", user: user_attributes
    token = response.to_str
    cookies[:hse_token] = { # TODO signed
        expires: 15.minutes.from_now,
        value: token,
        domain: Rails.env.production? ? domain : nil,
        httponly: true # TODO secure
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

  def user_attributes
    current_user.as_json(only: %i(id email roles first_name last_name))
  end

end
