# frozen_string_literal: true

require 'rails/generators/active_record'

module BeyondCanvas
  module Generators
    class ViewsGenerator < Rails::Generators::Base # :nodoc:
      desc 'Creates all Beyond Canvas views to overwrite them'

      source_root File.expand_path('../../../../app/views/beyond_canvas', __dir__)

      def copy_views
        directory 'authentications', 'app/views/beyond_canvas/authentications'
      end
    end
  end
end
