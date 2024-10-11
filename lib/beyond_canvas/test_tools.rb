# frozen_string_literal: true

# This module provides some tools to facilitate the testing of your applications
# Usage: add the following line in your config/environments/test.rb
# BeyondCanvas::TestTools.enable

module BeyondCanvas
  module TestTools
    class << self
      def enable
        enable_client_credentials
        create_authorized_shop_shared_context
      end

      private

      # Setup to retrieve the shop token using `grant_type=client_credentials`
      def enable_client_credentials
        BeyondCanvas.setup do |config|
          config.client_credentials = true
        end
      end

      # Creates an authorized shop for testing propouses
      # Usage: add the following line in your `_spec` file
      # include_context 'authorized shop'
      def create_authorized_shop_shared_context
        RSpec.shared_context 'authorized shop' do
          let(:shop) do
            Shop.new.tap do |shop|
              shop.beyond_api_url = "#{Rails.application.credentials.rspec[:shop_url]}/api"
              shop.reseller = Rails.application.credentials.rspec[:reseller_name]
              shop.beyond_access_token = shop.to_session.token.client_credentials.access_token
              shop.save!
            end
          end

          before(:each) do
            # Stub current_shop
            allow_any_instance_of(BeyondCanvas::AuthenticationsHelper).to receive(:current_shop).and_return(shop)
          end
        end
      end
    end
  end
end
