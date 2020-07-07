# frozen_string_literal: true

require 'beyond_canvas/engine'

require 'colorize'

require 'jquery-rails'
require 'bourbon'
require 'sassc-rails'
require 'inline_svg'
require 'http/accept'
require 'premailer/rails'

require 'beyond_api'
require 'attr_encrypted'
require 'blind_index'

module BeyondCanvas # :nodoc:
  autoload :AssetRegistration,  'beyond_canvas/asset_registration'
  autoload :Configuration,      'beyond_canvas/configuration'

  module Models # :nodoc:
    autoload :Authentication,   'beyond_canvas/models/authentication'
    autoload :Shop,             'beyond_canvas/models/shop'
    autoload :Utils,            'beyond_canvas/models/utils'
  end

  autoload :ParameterSanitizer, 'beyond_canvas/parameter_sanitizer'

  mattr_accessor :use_rails_app_controller
  @@use_rails_app_controller = false # rubocop:disable Style/ClassVars

  mattr_accessor :auth_model
  @@auth_model = 'shop' # rubocop:disable Style/ClassVars

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
