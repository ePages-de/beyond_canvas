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
    end

    initializer 'beyond_canvas.auth', after: :load_config_initializers do |app|
      ActiveSupport.on_load :action_controller do
        include ::BeyondCanvas::Authentication
      end
    end

    config.before_initialize do
      ActiveSupport.on_load :action_controller do
        include ::BeyondCanvas::LocaleManagement
        include ::BeyondCanvas::ResourceManagement
        include ::BeyondCanvas::RequestValidation
        include ::BeyondCanvas::StatusCodes

        ::ActionController::Base.helper BeyondCanvas::Engine.helpers
      end

      ActiveSupport.on_load :action_mailer do
        layout 'beyond_canvas/mailer'
      end
    end
  end
end
