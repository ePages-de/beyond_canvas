# frozen_string_literal: true

module BeyondCanvas
  module Authentication # :nodoc:
    extend ActiveSupport::Concern

    private

    def beyond_canvas_parameter_sanitizer
      @beyond_canvas_parameter_sanitizer ||= BeyondCanvas::ParameterSanitizer.new(:shop, params)
    end
  end
end
