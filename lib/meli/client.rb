class Meli::Client < Mercadolibre::Api
  include Singleton

  attr_writer :access_token
  delegate :config, :set_config, to: :class

  def initialize
    callback_url = Rails.application.routes.url_helpers.meli_auth_callback_url
    params = {
      app_key:      ENV.fetch('MELI_ID'),
      app_secret:   ENV.fetch('MELI_SECRET'),
      callback_url: callback_url,
      site:         'ARG',
      access_token: config[:access_token]
    }

    super(params)
  end

  def update_token
    super(config.fetch(:refresh_token)).tap do |resp|
      set_config(
        access_token: resp.access_token,
        expired_at:   resp.expired_at,
        refresh_token: resp.refresh_token
      )
    end
  end
end

class << Meli::Client
  CONFIG_PATH = Rails.root.join('tmp/meli.yml')

  def set_config(hash)
    File.open(CONFIG_PATH, 'w') do |f|
      f.write hash.to_yaml
    end
  end

  def config
    YAML.load_file(CONFIG_PATH) || {}
  rescue Errno::ENOENT
    {}
  end
end
