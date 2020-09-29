# frozen_string_literal: true

module BeyondCanvas
  module Generators
    class CustomMenuGenerator < Rails::Generators::Base # :nodoc:
      source_root File.expand_path('templates', __dir__)

      def copy_initializer
        copy_file 'beyond_canvas_custom_menu.html.erb', 'app/views/beyond_canvas/shared/_menu.html.erb'
      end
    end
  end
end
