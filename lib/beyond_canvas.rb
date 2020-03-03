# frozen_string_literal: true

require 'beyond_canvas/engine'

require 'colorize'

require 'bourbon'
require 'slim-rails'
require 'inline_svg'

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
      @stylesheet_link_tag = nil
      @javascript_include_tag = nil
    end
  end
end
