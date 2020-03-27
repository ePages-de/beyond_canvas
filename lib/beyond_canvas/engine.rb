# frozen_string_literal: true

module BeyondCanvas
  class Engine < ::Rails::Engine
    isolate_namespace BeyondCanvas

    config.before_initialize do
      ActiveSupport.on_load :action_controller do
        include ::BeyondCanvas::LocaleManagement

        ::ActionController::Base.helper BeyondCanvas::Engine.helpers
      end
    end
  end
end
