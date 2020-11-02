# frozen_string_literal: true

module BeyondCanvas
  module ControllerHelper # :nodoc:
    def beyond_canvas_controller?
      self.class.const_defined?(:BeyondCanvas)
    end
  end
end
