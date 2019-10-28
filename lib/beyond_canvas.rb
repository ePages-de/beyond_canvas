require "beyond_canvas/version"

module BeyondCanvas
  class Engine < ::Rails::Engine
    config.before_initialize do
      if config.action_view.javascript_expansions
        config.action_view.javascript_expansions[:beyond_canvas] = %w(beyond_canvas)
      end
    end
  end
end
