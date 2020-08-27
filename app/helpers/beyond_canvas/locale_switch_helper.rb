# frozen_string_literal: true

module BeyondCanvas
  module LocaleSwitchHelper # :nodoc:
    def show_locale_switch?
      defined?(I18n) && I18n.available_locales.count > 1
    end

    def translate_locale(locale)
      if I18n.exists?("locales.#{locale}")
        I18n.t("locales.#{locale}")
      else
        logger.debug "[BeyondCanvas] Missing translation: #{I18n.locale}.locales.#{locale}".yellow if debug_mode?
        locale
      end
    end
  end
end
