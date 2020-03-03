# frozen_string_literal: true

module BeyondCanvas
  module Generators
    class CustomStylesGenerator < Rails::Generators::Base
      source_root File.expand_path('../templates', __dir__)

      def copy_initializer
        template 'beyond_canvas_custom_styles.sass', 'app/assets/stylesheets/_beyond_canvas_custom_styles.sass'
      end
    end
  end
end
