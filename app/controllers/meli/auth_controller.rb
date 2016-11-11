class Meli::AuthController < ApplicationController
  def redirect
    redirect_to Meli::Client.instance.authenticate_url
  end

  def callback
    code      = params.fetch(:code)
    auth_data = Meli::Client.instance.authenticate(code)

    Meli::Client.instance.set_config(
      access_token:  auth_data.access_token,
      expired_at:    auth_data.expired_at,
      refresh_token: auth_data.refresh_token
    )

    render json: Meli::Client.instance.config
  end
end
