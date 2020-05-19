# frozen_string_literal: true

module BeyondCanvas
  module Generators
    class AssetsGenerator < Rails::Generators::Base # :nodoc:
      source_root File.expand_path('templates', __dir__)

      def install_assets
        template 'beyond_canvas.js', 'app/assets/javascripts/beyond_canvas.js'
        template 'beyond_canvas.scss', 'app/assets/stylesheets/beyond_canvas.scss'
      end
    end
  end
end
