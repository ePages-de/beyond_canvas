# frozen_string_literal: true

module BeyondCanvas
  module AuthenticationsHelper # :nodoc:
    #
    # Logs in the given shop
    #
    def log_in(shop)
      cookies[:shop_id] = {
        value: shop.id
      }.merge COOKIES_ATTRIBUTES
      session[:shop_id] = shop.id
    end

    #
    # Returns the current logged-in shop (if any)
    #
    def current_shop
      puts '*' * 75
      puts request.session
      puts "PATH: #{request.path}"
      puts '*' * 75
      if session[:shop_id]
        @current_shop ||= Shop.find_by(id: session[:shop_id])
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
