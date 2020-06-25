# frozen_string_literal: true

module ActionDispatch::Routing
  class Mapper
    def beyond_canvas_for(*resources)
      mount BeyondCanvas::Engine => BeyondCanvas.configuration.mounting_path

      resource_name, options = resources
      BeyondCanvas.auth_model = resource_name.to_s.singularize
      BeyondCanvas.use_rails_app_controller = options.present? && options[:controller].present?

      if BeyondCanvas.use_rails_app_controller
        set_routes(resource_name, options[:controller])
      end
    end

    def set_routes(resource_name, controller)
      resources resource_name, controller: controller
    end
  end
end
