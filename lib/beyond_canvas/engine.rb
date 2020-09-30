# frozen_string_literal: true

require 'beyond_canvas/rails/routes'

module BeyondCanvas
  class Engine < ::Rails::Engine # :nodoc:
    isolate_namespace BeyondCanvas

    initializer 'beyond_canvas.assets.precompile' do |app|
      BeyondCanvas.configuration.stylesheets.each do |path, _|
        app.config.assets.precompile << path
      end
      BeyondCanvas.configuration.javascripts.each do |path|
        app.config.assets.precompile << path
      end

      app.config.assets.precompile << 'beyond_canvas_manifest.js'
    end

    config.before_initialize do
      ActiveSupport.on_load :action_controller do
        include ::BeyondCanvas::LocaleManagement
        include ::BeyondCanvas::RequestValidation
        include ::BeyondCanvas::StatusCodes
        include ::BeyondCanvas::AuthenticationsHelper
        include ::BeyondCanvas::DebugHelper

        ::ActionController::Base.helper BeyondCanvas::Engine.helpers
      end

      ActiveSupport.on_load :action_mailer do
        layout 'beyond_canvas/mailer'
      end
    end
  end
end
