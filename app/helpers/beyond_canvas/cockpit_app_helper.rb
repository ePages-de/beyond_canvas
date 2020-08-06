# frozen_string_literal: true

module BeyondCanvas
  module CockpitAppHelper # :nodoc:
    def is_cockpit_app?
      BeyondCanvas.configuration.cockpit_app == true
    end

    def menu_content?
      content_for?(:menu_left) || content_for?(:menu_right)
    end
  end
end
