# frozen_string_literal: true

module ActionDispatch
  module Routing
    class Mapper # :nodoc:
      def beyond_canvas_routes(options = nil)
        mount BeyondCanvas::Engine => BeyondCanvas.configuration.namespace

        BeyondCanvas.use_rails_app_controller = options.present? && options[:custom_controller].present?

        set_routes if BeyondCanvas.use_rails_app_controller
      end

      def set_routes
        scope BeyondCanvas.configuration.namespace do
          get  'callback', controller: :authentications, action: :new
          post 'callback', controller: :authentications, action: :install
        end
      end
    end
  end
end
