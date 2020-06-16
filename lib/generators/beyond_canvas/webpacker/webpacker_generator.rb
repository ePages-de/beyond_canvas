# frozen_string_literal: true

module BeyondCanvas
  module Generators
    class WebpackerGenerator < Rails::Generators::Base # :nodoc:
      source_root File.expand_path('templates', __dir__)

      def install_assets
        template 'beyond_canvas.js', 'app/javascript/packs/beyond_canvas.js'
        template 'beyond_canvas.scss', 'app/javascript/stylesheets/beyond_canvas.scss'

        copy_file "#{__dir__}/plugins/jquery.js", Rails.root.join('config/webpack/plugins/jquery.js').to_s

        insert_into_file Rails.root.join('config/webpack/environment.js').to_s,
                         "const jquery = require('./plugins/jquery')\n",
                         after: %r{require\(('|")@rails/webpacker\1\);?\n}

        insert_into_file Rails.root.join('config/webpack/environment.js').to_s,
                         "environment.plugins.prepend('jquery', jquery)\n",
                         before: 'module.exports'

        run 'yarn add @epages/beyond_canvas'
      end
    end
  end
end
