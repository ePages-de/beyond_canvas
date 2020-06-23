# frozen_string_literal: true

require 'rails/generators/active_record'

module BeyondCanvas
  module Generators
    class AuthModelGenerator < ActiveRecord::Generators::Base
      desc "Generates a model with the given name and provides a method to authenticate in Beyond Backend"

      argument :attributes, type: :array, default: [], banner: "field:type field:type"

      source_root File.expand_path("../templates", __FILE__)

      def copy_beyond_canvas_migration
        migration_path = File.join("db", "migrate")
        migration_template "migration.rb", "#{migration_path}/beyond_canvas_create_#{table_name}.rb", migration_version: migration_version
      end

      def generate_model
        template "model.rb", File.join("app", "models", "#{file_path}.rb")
      end

      private

      def rails5_and_up?
        Rails::VERSION::MAJOR >= 5
      end

      def migration_version
        if rails5_and_up?
          "[#{Rails::VERSION::MAJOR}.#{Rails::VERSION::MINOR}]"
        end
      end

      def migration_data
<<RUBY
      t.string :encrypted_beyond_api_url,       null: false
      t.string :encrypted_beyond_api_url_iv,    null: false
      t.string :beyond_api_url_bidx,            null: false

      t.text :encrypted_beyond_access_token,    null: true
      t.text :encrypted_beyond_access_token_iv, null: true

      t.text :encrypted_beyond_refresh_token,    null: true
      t.text :encrypted_beyond_refresh_token_iv, null: true
RUBY
      end
    end
  end
end
