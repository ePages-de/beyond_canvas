# frozen_string_literal: true

module BeyondCanvas
  module Generators
    class InstallGenerator < Rails::Generators::Base
      desc 'Installs Beyond Canvas and generates the necessary files'

      class_option :skip_webpacker, type: :boolean, default: false, desc: 'Use Sprockets assets instead of Webpacker'

      source_root File.expand_path('templates', __dir__)

      def copy_initializer
        @skip_webpacker = options[:skip_webpacker]

        template 'beyond_canvas.rb', 'config/initializers/beyond_canvas.rb'
      end

      def setup_routes
        route "mount BeyondCanvas::Engine => '/'"
      end

      def create_assets
        if options[:skip_webpacker]
          generate 'beyond_canvas:assets'
        else
          generate 'beyond_canvas:webpacker'
        end
      end

      def install_beyond_api
        generate 'beyond_api:install'
      end
    end
  end
end
