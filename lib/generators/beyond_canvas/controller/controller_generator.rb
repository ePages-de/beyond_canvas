# frozen_string_literal: true

module BeyondCanvas
  module Generators
    class ControllerGenerator < Rails::Generators::Base # :nodoc:
      desc 'Creates an inherited Beyond Canvas controller in the app/controllers folder'

      source_root File.expand_path('templates', __dir__)

      def create_controller
        template 'shops_controller.rb', "app/controllers/shops_controller.rb"
      end
    end
  end
end
