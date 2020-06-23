# frozen_string_literal: true

require 'rails/generators/active_record'

module BeyondCanvas
  module Generators
    class ViewsGenerator < Rails::Generators::Base
      desc "Creates a view in the app/view folder"

      source_root File.expand_path("../templates", __FILE__)
      argument :scope, required: true,
        desc: "The scope to copy views to"

      def create_view
        copy_file "new.html.erb", "app/views/#{scope}/new.html.erb"
      end
    end
  end
end
