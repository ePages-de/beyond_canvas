# frozen_string_literal: true

module BeyondCanvas
  module Generators
    class WebhookGenerator < Rails::Generators::Base # :nodoc:
      desc 'Creates an inherited Beyond Canvas controller in the app/controllers/beyond_canvas folder'

      source_root File.expand_path('templates', __dir__)

      def create_controller
        template 'beyond_webhook_controller.rb', "app/controllers/beyond_canvas/beyond_webhook_controller.rb"
      end
    end
  end
end
