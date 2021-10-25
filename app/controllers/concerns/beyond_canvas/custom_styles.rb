# frozen_string_literal: true

module BeyondCanvas
  module CustomStyles
    extend ActiveSupport::Concern

    included do
      before_action :check_custom_styles!
    end

    private

    #
    # Checks if the custom styles url set on `custom_styles_url` cookie is valid. If it's not, it generates a new custom
    # styles url and stores it on `custom_styles_url` cookie.
    #
    def check_custom_styles!
      cookies.delete(:custom_styles_url) and return unless BeyondCanvas.configuration.custom_styles?

      return if valid_custom_styles_stylesheet?(cookies[:custom_styles_url])

      set_custom_styles_url
    end

    #
    # Validates if the `custom_styles_url` cookie is set and if it's a valid url.
    #
    def valid_custom_styles_stylesheet?(custom_styles_url)
      custom_styles_url.present? && existing_url?(custom_styles_url)
    end

    #
    # Checks if the given url exists.
    #
    def existing_url?(url)
      URI.open(url).status.first.to_i.between?(200, 299)
    rescue
      false
    end

    #
    # Stores a newly generated custom_styles_url on the cookie.
    #
    def set_custom_styles_url(shop = nil)
      shop ||= current_shop

      return if shop.blank?

      shop.refresh_token_if_needed

      reseller = shop.to_session.shop.current[:reseller_name]
      custom_styles_url = shop.url("cockpit/assets/reseller-styles/#{reseller}-variables.css")

      reseller = 'base' unless existing_url?(custom_styles_url)


      cookies[:custom_styles_url] = {
        value: shop.url("cockpit/assets/reseller-styles/#{reseller}-variables.css")
      }.merge COOKIES_ATTRIBUTES
    end
  end
end
