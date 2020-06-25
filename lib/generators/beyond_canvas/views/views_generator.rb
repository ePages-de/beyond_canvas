# frozen_string_literal: true

require 'rails/generators/active_record'

module BeyondCanvas
  module Generators
    class ViewsGenerator < Rails::Generators::Base # :nodoc:
      desc 'Creates a view in the app/view folder'

      argument :scope, required: true, desc: 'The scope to copy views to'

      source_root File.expand_path('../../../../app/views/beyond_canvas/authentications', __dir__)

      def create_view
        copy_file 'new.html.erb', "app/views/#{scope}/new.html.erb"
      end
    end
  end
end
