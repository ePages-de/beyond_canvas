# frozen_string_literal: true

module BeyondCanvas
  module DebugHelper # :nodoc:
    def debug_mode?
      Rails.env.development? && BeyondCanvas.configuration.debug_mode
    end
  end
end
