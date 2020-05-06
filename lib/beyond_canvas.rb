# frozen_string_literal: true

require 'beyond_canvas/engine'

require 'colorize'

require 'bourbon'
require 'inline_svg'
require 'http/accept'
require 'premailer/rails'

require 'beyond_api'

module BeyondCanvas
  class << self
    attr_accessor :configuration
  end

  def self.setup
    self.configuration ||= Configuration.new

    yield configuration
  end

  class Configuration
    attr_accessor :public_logo, :stylesheet_link_tag, :javascript_include_tag

    def initialize
      @public_logo = nil
      @stylesheet_link_tag = 'application'
      @javascript_include_tag = 'application'
    end
  end
end
