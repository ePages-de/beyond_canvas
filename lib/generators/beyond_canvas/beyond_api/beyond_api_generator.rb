# frozen_string_literal: true

module BeyondCanvas
  module Generators
    class BeyondApiGenerator < Rails::Generators::Base
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
