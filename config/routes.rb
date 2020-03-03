# frozen_string_literal: true

BeyondCanvas::Engine.routes.draw do
  put '/locale', to: 'application#update_locale', as: :update_locale
end
