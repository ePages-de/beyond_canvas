# frozen_string_literal: true

module BeyondCanvas
  module AuthenticationsHelper # :nodoc:
    #
    # Logs in the given shop
    #
    def log_in(shop)
      cookies[:shop_id] = {
        same_site: :none,
        http_only: true,
        secure: :true,
        tld_length: 2,
        value: shop.id
      }
    end

    #
    # Returns the current logged-in shop (if any)
    #
    def current_shop
      puts '@' * 75
      puts request.env["HTTP_HOST"]
      puts cookies[:shop_id]
      puts '@' * 75
      if cookies[:shop_id]
        @current_shop ||= Shop.find_by(id: cookies[:shop_id])
      end
    end

    #
    # Returns true if the shop is logged in, false otherwise
    #
    def logged_in?
      !current_shop.nil?
    end
  end
end
