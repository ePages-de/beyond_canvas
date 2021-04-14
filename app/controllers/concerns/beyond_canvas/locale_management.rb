# frozen_string_literal: true

module BeyondCanvas
  module LocaleManagement # :nodoc:
    extend ActiveSupport::Concern

    included do
      around_action :switch_locale, except: :update_locale # rubocop:disable Rails/LexicallyScopedActionFilter
    end

    private

    #
    # Sets the cookie locale as default locale if it is a valid locale. If it is not a valid locale, searches for a
    # browser compatible locale, sets the value to the cookie and set that locale as default locale.
    #
    def switch_locale(&action)
      unless valid_locale?(cookies[:locale])
        cookies[:locale] = {
          value: app_locale
        }.merge COOKIES_ATTRIBUTES
      end

      I18n.with_locale(cookies[:locale], &action)

      logger.debug "[BeyondCanvas] Locale set to: #{cookies[:locale]}".yellow if debug_mode?
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
      return I18n.default_locale if request.headers['HTTP_ACCEPT_LANGUAGE'].blank?

      browser_locales = HTTP::Accept::Languages.parse(request.headers['HTTP_ACCEPT_LANGUAGE'])
      available_locales = HTTP::Accept::Languages::Locales.new(I18n.available_locales.map(&:to_s))

      locales = available_locales & browser_locales

      locales.empty? ? I18n.default_locale : locales.first
    rescue
      I18n.default_locale
    end

    #
    # Checks if the given locale parameter is included on +I18n.available_locales+
    #
    def valid_locale?(locale)
      I18n.available_locales.map(&:to_s).include? locale
    end

    def app_locale
      BeyondCanvas.configuration.cockpit_app ? shop_locale : browser_compatible_locale
    end

    def shop_locale
      BeyondApi::Session.new(api_url: current_shop.beyond_api_url).shop.current.default_locale
    rescue
      browser_compatible_locale
    end
  end
end
