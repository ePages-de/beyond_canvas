# frozen_string_literal: true

BeyondCanvas::Engine.routes.draw do
  put '/locale', to: 'locales#update'
end
