# frozen_string_literal: true

module BeyondCanvas
  module LocaleManagement
    extend ActiveSupport::Concern

    included do
      before_action :set_locale, except: :update_locale
    end

    private

    #
    # Sets the I18n.locale to either +cookies[ :locale ]+ or the browser
    # compatible locale (if +cookies[ :locale ]+ is not set)
    #
    def set_locale
      unless valid_locale?(cookies[:locale])
        cookies[:locale] = { value: browser_compatible_locale, expires: 1.day.from_now }
      end

      I18n.locale = cookies[:locale]

      logger.debug "[BeyondCanvas] Locale set to: #{I18n.locale}".yellow
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
    # Checks if the given locale parameter is included on +I18n.available_locales+
    #
    def valid_locale?(locale)
      I18n.available_locales.map(&:to_s).include? locale
    end
  end
end
