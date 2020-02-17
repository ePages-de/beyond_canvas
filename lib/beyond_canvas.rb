require "beyond_canvas/version"

require "bourbon"
require "slim-rails"
require "inline_svg"

module BeyondCanvas
  class Error < StandardError; end

  class Engine < ::Rails::Engine
    config.before_initialize do
      if config.action_view.javascript_expansions
        config.action_view.javascript_expansions[:beyond_canvas] = %w(beyond_canvas)
      end
    end
  end

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
