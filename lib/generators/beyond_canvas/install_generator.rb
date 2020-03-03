# frozen_string_literal: true

module BeyondCanvas
  module Generators
    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path('../templates', __dir__)

      def copy_initializer
        template 'beyond_canvas.rb', 'config/initializers/beyond_canvas.rb'
      end
    end
  end
end
