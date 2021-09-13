# frozen_string_literal: true

module ActionDispatch
  module Routing
    class Mapper # :nodoc:
      def beyond_canvas_routes(*resources)
        scope BeyondCanvas.configuration.namespace do
          put 'locale', to: 'beyond_canvas/system#update_locale', as: :update_locale
        end

        resources = resources.extract_options!

        beyond_canvas_for_controllers(resources[:controllers] || {})
      end

      protected

      def beyond_canvas_for_controllers(controllers)
        [:authentications, :webhooks].each do |method|
          controllers.key?(method) ? send("set_#{method}_routes", controllers[method]) : send("set_#{method}_routes")
        end
      end

      def set_webhooks_routes(controller = 'beyond_canvas/webhooks')
        scope BeyondCanvas.configuration.namespace do
          resources :shops, only: [] do
            member do
              post :beyond_webhook, controller: controller, action: :webhook
            end
          end
        end
      end

      def set_authentications_routes(controller = 'beyond_canvas/authentications')
        scope BeyondCanvas.configuration.namespace do
          get  'callback', controller: controller, action: :new
          post 'callback', controller: controller, action: :install
        end
      end
    end
  end
end
