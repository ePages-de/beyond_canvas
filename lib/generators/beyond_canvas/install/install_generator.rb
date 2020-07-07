# frozen_string_literal: true

module BeyondCanvas
  module Generators
    class InstallGenerator < Rails::Generators::Base # :nodoc:
      desc 'Installs Beyond Canvas and generates the necessary files'

      class_option :skip_webpacker, type: :boolean, default: false, desc: 'Use Sprockets assets instead of Webpacker'
      class_option :auth_model, type: :string, default: 'shop', desc: 'Authentication model'

      source_root File.expand_path('templates', __dir__)

      def copy_initializer
        @skip_webpacker = options[:skip_webpacker]
        @auth_model = options[:auth_model]

        template 'beyond_canvas.rb.erb', 'config/initializers/beyond_canvas.rb'
      end

      def create_assets
        if options[:skip_webpacker]
          generate 'beyond_canvas:assets'
        else
          generate 'beyond_canvas:webpacker'
        end
      end

      def install_beyond_api
        generate 'beyond_canvas:beyond_api'
      end

      def generate_auth_model
        generate "beyond_canvas:auth_model #{@auth_model}"
      end

      def setup_routes
        route "beyond_canvas_for :#{@auth_model.pluralize}"
      end

      def copy_locale
        copy_file '../../../../../config/locales/en.yml', 'config/locales/beyond_canvas.en.yml'
      end
    end
  end
end
