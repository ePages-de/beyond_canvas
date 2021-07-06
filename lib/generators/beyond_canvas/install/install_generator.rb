# frozen_string_literal: true

module BeyondCanvas
  module Generators
    class InstallGenerator < Rails::Generators::Base # :nodoc:
      desc 'Installs Beyond Canvas and generates the necessary files'

      class_option :skip_webpacker, type: :boolean, default: false, desc: 'Use Sprockets assets instead of Webpacker'

      source_root File.expand_path('templates', __dir__)

      def copy_initializer
        @skip_webpacker = options[:skip_webpacker]

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

      def generate_model
        generate 'beyond_canvas:model shop'
      end

      def setup_routes
        route 'beyond_canvas_routes'
      end

      def copy_locale
        copy_file '../../../../../config/locales/en.yml', 'config/locales/beyond_canvas.en.yml'
      end

      def copy_public
        Dir[File.join(BeyondCanvas::Engine.root, 'public', '*')].each do |file|
          copy_file file, File.join(Rails.root, 'public', File.basename(file))
        end
      end
    end
  end
end
