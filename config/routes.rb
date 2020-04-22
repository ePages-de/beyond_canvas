# frozen_string_literal: true

BeyondCanvas::Engine.routes.draw do
  put '/locale', to: 'system#update_locale', as: :update_locale
end
