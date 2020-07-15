# frozen_string_literal: true

BeyondCanvas::Engine.routes.draw do
  put '/locale', to: 'system#update_locale', as: :update_locale

  def create_default_routes(resource_name)
    resources resource_name, controller: 'authentications', except: :destroy
  end

  create_default_routes(BeyondCanvas.auth_model.pluralize.to_sym) unless BeyondCanvas.use_rails_app_controller
end
