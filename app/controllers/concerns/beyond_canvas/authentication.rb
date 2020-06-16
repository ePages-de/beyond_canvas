# frozen_string_literal: true

module BeyondCanvas
  module Authentication # :nodoc:
    extend ActiveSupport::Concern
    AUTH_RESOURCE = BeyondCanvas.configuration.auth_model

    class_eval <<-METHODS, __FILE__, __LINE__ + 1
      def authenticate_#{AUTH_RESOURCE}!
        authenticate_resource
      end

      def current_#{AUTH_RESOURCE}
        instance_variable_get("@#{AUTH_RESOURCE}")
      end

      def new_#{AUTH_RESOURCE}_params
        beyond_canvas_parameter_sanitizer.sanitize
      end


    METHODS

    private

    def authenticate_resource
      klass = AUTH_RESOURCE.classify.constantize
      klass.transaction do
        # Search for the api url. If there is no record it creates a new record.
        new_resource_params = send "new_#{AUTH_RESOURCE}_params"
        instance = instance_variable_set("@#{AUTH_RESOURCE}", klass.find_or_create_by(beyond_api_url: new_resource_params[:api_url]))
        # Assign the attributes to the record
        if instance.update(new_resource_params)
          # Get and save access_token and refresh_token using the authentication code
          instance.authenticate
        else
          raise ActiveRecord::RecordNotSaved, 'Invalid Record'
        end
      end
    end

    def beyond_canvas_parameter_sanitizer
      @beyond_canvas_parameter_sanitizer ||= BeyondCanvas::ParameterSanitizer.new(AUTH_RESOURCE, params)
    end
  end
end
