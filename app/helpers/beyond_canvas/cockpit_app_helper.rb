# frozen_string_literal: true

module BeyondCanvas
  module CockpitAppHelper # :nodoc:
    def is_cockpit_app?
      BeyondCanvas.configuration.cockpit_app == true
    end

    def action_bar_content?
      content_for?(:action_bar_left) || content_for?(:action_bar_right)
    end
  end
end
