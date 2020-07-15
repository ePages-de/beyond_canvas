# frozen_string_literal: true

module ActionDispatch
  module Routing
    class Mapper # :nodoc:
      def beyond_canvas_for(*resources)
        mount BeyondCanvas::Engine => BeyondCanvas.configuration.namespace

        resource_name, options = resources
        BeyondCanvas.auth_model = resource_name.to_s.singularize
        BeyondCanvas.use_rails_app_controller = options.present? && options[:controller].present?

        set_routes(resource_name, options[:controller]) if BeyondCanvas.use_rails_app_controller
      end

      def set_routes(resource_name, controller)
        resources resource_name, controller: controller
      end
    end
  end
end
