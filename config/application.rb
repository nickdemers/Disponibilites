#require File.expand_path('../boot', __FILE__)

#require "active_record/railtie"
#require "action_controller/railtie"
#require "action_mailer/railtie"
#require "active_resource/railtie"
#require "sprockets/railtie"

require "rails/all"

#if Rails.env.development?
#  OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE
#end

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
#Bundler.require(:default, Rails.env)
Bundler.require(*Rails.groups)

#config.active_record.whitelist_attributes = false

module Disponibilites
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
    config.sass.load_paths << File.expand_path('../../lib/assets/stylesheets/')
    config.sass.load_paths << File.expand_path('../../vendor/assets/stylesheets/')

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    config.time_zone = "Eastern Time (US & Canada)"

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
     config.i18n.default_locale = :fr

    config.generators do |g|
      g.test_framework :rspec
    end
  end
end
