# frozen_string_literal: true

module BeyondCanvas
  class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception
    before_action :set_locale, except: :update_locale

    ############################################################################
    # Locale management
    ############################################################################

    def update_locale
      if I18n.available_locales.map(&:to_s).include? app_locale_params[:locale]
        session[:locale] = app_locale_params[:locale]
        set_locale
      end

      redirect_back(fallback_location: main_app.root_path)
    end

    private

    ############################################################################
    # Locale management
    ############################################################################

    #
    # Sets the I18n.locale to either +session[ :locale ]+ or the browser
    # compatible locale (if +session[ :locale ]+ is not set)
    #
    def set_locale
      I18n.locale = session[:locale] || session[:locale] = browser_compatible_locale
    end

    #
    # Reads the +HTTP_ACCEPT_LANGUAGE+ header and searches a compatible locale
    # on +I18n.available_locales+. If no compatible language is found, it
    # returns +I18n.default_locale+.
    #
    # @return [String] a browser compatible language string or
    #   +I18n.default_locale+. (e.g. +'en-GB'+)
    #
    def browser_compatible_locale
      browser_locales = HTTP::Accept::Languages.parse(request.headers['HTTP_ACCEPT_LANGUAGE'])
      available_locales = HTTP::Accept::Languages::Locales.new(I18n.available_locales.map(&:to_s))

      locales = available_locales & browser_locales

      locales.empty? ? I18n.default_locale : locales.first
    end

    #
    # Strong parameters for locale switch
    #
    def app_locale_params
      params.require(:app).permit(:locale)
    end
  end
end
