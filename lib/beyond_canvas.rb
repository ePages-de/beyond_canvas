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

module BeyondCanvas # :nodoc:
  autoload :AssetRegistration, 'beyond_canvas/asset_registration'
  autoload :Configuration,     'beyond_canvas/configuration'

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
