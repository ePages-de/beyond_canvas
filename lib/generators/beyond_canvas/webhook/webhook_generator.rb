# frozen_string_literal: true

module BeyondCanvas
  module Generators
    class WebhookGenerator < Rails::Generators::Base # :nodoc:
      desc 'Creates an inherited Webhook controller in the app/controllers folder'

      source_root File.expand_path('templates', __dir__)

      def create_controller
        template 'webhooks_controller.rb', "app/controllers/webhooks_controller.rb"
      end
    end
  end
end
