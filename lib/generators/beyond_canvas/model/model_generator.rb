# frozen_string_literal: true

require 'rails/generators/active_record'

module BeyondCanvas
  module Generators
    class ModelGenerator < ActiveRecord::Generators::Base # :nodoc:
      desc 'Generates a model with the given name and provides a method to authenticate in Beyond Backend'

      argument :attributes, type: :array, default: [], banner: 'field:type field:type'

      source_root File.expand_path('templates', __dir__)

      def copy_beyond_canvas_migration
        migration_path = File.join('db', 'migrate')
        migration_template 'migration.erb',
                           "#{migration_path}/beyond_canvas_create_#{table_name}.rb",
                           migration_version: migration_version
      end

      def generate_model
        template 'model.erb', File.join("app/models/#{file_path}.rb")
      end

      private

      def rails5_and_up?
        Rails::VERSION::MAJOR >= 5
      end

      def migration_version
        "[#{Rails::VERSION::MAJOR}.#{Rails::VERSION::MINOR}]" if rails5_and_up?
      end

      def migration_data
        <<RUBY
      t.string :beyond_api_url, null: false

      t.text :encrypted_beyond_access_token,    null: true
      t.text :encrypted_beyond_access_token_iv, null: true

      t.text :encrypted_beyond_refresh_token,    null: true
      t.text :encrypted_beyond_refresh_token_iv, null: true

RUBY
      end
    end
  end
end
