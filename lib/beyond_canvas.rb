# frozen_string_literal: true

require 'beyond_canvas/engine'

require 'colorize'

require 'jquery-rails'
require 'bourbon'
require 'sassc-rails'
require 'inline_svg'
require 'loaf'
require 'http/accept'
require 'premailer/rails'

require 'beyond_api'
require 'attr_encrypted'


module BeyondCanvas # :nodoc:
  autoload :AssetRegistration,        'beyond_canvas/asset_registration'
  autoload :Configuration,            'beyond_canvas/configuration'
  autoload :MenuItemRegistration,     'beyond_canvas/menu_item_registration'
  autoload :ParameterSanitizer,       'beyond_canvas/parameter_sanitizer'
  autoload :WebhookEventRegistration, 'beyond_canvas/webhook_event_registration'

  module Middleware
    autoload :CockpitAppHeader,         'beyond_canvas/middleware/cockpit_app_header'
  end


  module Models # :nodoc:
    autoload :Shop, 'models/shop'

    module Concerns
      autoload :Authentication, 'models/concerns/authentication'
      autoload :Utils,          'models/concerns/utils'
      autoload :Webhook,        'models/concerns/webhook'
    end
  end

  mattr_accessor :use_rails_app_controller
  @@use_rails_app_controller = false

  class << self
    def configuration
      @configuration ||= ::BeyondCanvas::Configuration.new
    end

    def setup
      configuration.setup!
      yield configuration
    end
  end
end
