# frozen_string_literal: true

module BeyondCanvas
  module Authentication # :nodoc:
    extend ActiveSupport::Concern
    AUTH_RESOURCE = BeyondCanvas.auth_model

    class_eval <<-METHODS, __FILE__, __LINE__ + 1
      def current_#{AUTH_RESOURCE}
        instance_variable_get("@#{AUTH_RESOURCE}")
      end

      def new_#{AUTH_RESOURCE}_params
        beyond_canvas_parameter_sanitizer.sanitize
      end
    METHODS

    private

    def beyond_canvas_parameter_sanitizer
      @beyond_canvas_parameter_sanitizer ||= BeyondCanvas::ParameterSanitizer.new(AUTH_RESOURCE, params)
    end
  end
end
