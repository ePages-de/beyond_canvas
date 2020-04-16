# frozen_string_literal: true

module BeyondCanvas
  module Generators
    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path('../templates', __dir__)

      def copy_initializer
        template 'beyond_canvas.rb', 'config/initializers/beyond_canvas.rb'
      end

      def install_beyond_api
        require 'beyond_api'

        initializer_file = File.join(destination_root, 'config/initializers/beyond_api.rb')

        if File.exist?(initializer_file)
          log :generate, 'No need to install beyond_api, already done.'
        else
          invoke 'beyond_api:install'
        end
      end
    end
  end
end
