# frozen_string_literal: true

require 'rails/generators/active_record'

module BeyondCanvas
  module Generators
    class ControllerGenerator < Rails::Generators::Base
      desc "Creates an inherited Beyond Canvas controller in the app/controllers folder"

      source_root File.expand_path("../templates", __FILE__)
      argument :scope, required: true,
        desc: "The scope to create the controller, e.g. shops, users"

      def create_controller
        template "controller.rb",
                 "app/controllers/#{scope}_controller.rb"
      end
    end
  end
end
