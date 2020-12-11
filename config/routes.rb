# frozen_string_literal: true

BeyondCanvas::Engine.routes.draw do
  put 'locale', to: 'system#update_locale', as: :update_locale

  def create_default_routes
    get  'callback', to: 'authentications#new'
    post 'callback', to: 'authentications#install'
  end

  create_default_routes unless BeyondCanvas.use_rails_app_controller
end
