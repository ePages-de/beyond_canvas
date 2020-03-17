# frozen_string_literal: true

module BeyondCanvas
  class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception

    include ::BeyondCanvas::LocaleManagement
  end
end
