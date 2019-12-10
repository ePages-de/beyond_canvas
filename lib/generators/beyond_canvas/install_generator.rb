# frozen_string_literal: true

module BeyondCanvas
  module Generators
    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path("../../templates", __FILE__)

      def copy_initializer
        template "beyond_canvas.rb", "config/initializers/beyond_canvas.rb"
        template "beyond_canvas_form_utils.rb", "config/initializers/beyond_canvas_form_utils.rb"
      end
    end
  end
end
