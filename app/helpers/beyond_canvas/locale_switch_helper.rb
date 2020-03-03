# frozen_string_literal: true

module BeyondCanvas
  module LocaleSwitchHelper
    def translate_locale(locale)
      if I18n.exists?("locales.#{locale}")
        I18n.t("locales.#{locale}")
      else
        logger.debug "[BeyondCanvas] Missing translation: #{I18n.locale}.locales.#{locale}".yellow
        locale
      end
    end
  end
end
