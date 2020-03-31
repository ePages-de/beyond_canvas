# frozen_string_literal: true

module BeyondCanvas
  class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception

    include ::BeyondCanvas::LocaleManagement

    def update_locale
      cookies[:locale] = { value: app_locale_params[:locale], expires: 1.day.from_now }
      set_locale

      redirect_back(fallback_location: main_app.root_path)
    end

    private

    #
    # Strong parameters for locale switch
    #
    def app_locale_params
      params.require(:app).permit(:locale)
    end
  end
end
