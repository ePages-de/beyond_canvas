# frozen_string_literal: true

module BeyondCanvas
  class Engine < ::Rails::Engine
    isolate_namespace BeyondCanvas

    config.before_initialize do
      ActiveSupport.on_load :action_controller do
        include ::BeyondCanvas::LocaleManagement
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
