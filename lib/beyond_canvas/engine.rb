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

    initializer 'beyond_canvas.session' do |app|
      if BeyondCanvas.configuration.cockpit_app == true && Rails.env.production?
        app.config.session_store :cookie_store, secure: true, same_site: :none
      end
    end

    initializer "beyond_canvas.add_middleware" do |app|
      if BeyondCanvas.configuration.cockpit_app == true
        app.middleware.use BeyondCanvas::Middleware::CockpitAppHeader
      end
    end

    # SEE:  https://guides.rubyonrails.org/engines.html#available-load-hooks

    config.before_initialize do
      ActiveSupport.on_load :action_controller do
        include ::BeyondCanvas::LocaleManagement
        include ::BeyondCanvas::RequestValidation
        include ::BeyondCanvas::CustomStyles
        include ::BeyondCanvas::StatusCodes
        include ::BeyondCanvas::AuthenticationsHelper
        include ::BeyondCanvas::DebugHelper
        include ::BeyondCanvas::ControllerHelper

        ::ActionController::Base.helper BeyondCanvas::Engine.helpers
      end
    end

    config.after_initialize do
      ActiveSupport.on_load :action_controller do
        include ::BeyondCanvas::AddBlockerCheck
      end

      require_relative '../beyond_canvas/constants'
    end
  end
end
