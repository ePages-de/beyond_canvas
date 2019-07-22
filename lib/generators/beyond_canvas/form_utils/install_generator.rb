# frozen_string_literal: true

module BeyondCanvas
  module FormUtils
    module Generators
      class InstallGenerator < Rails::Generators::Base
        source_root File.expand_path("../../../templates", __FILE__)

        def copy_initializer
          template "beyond_canvas_form_utils.rb", "config/initializers/beyond_canvas_form_utils.rb"
        end
      end
    end
  end
end
