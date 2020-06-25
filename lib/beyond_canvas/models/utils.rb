# frozen_string_literal: true

module BeyondCanvas
  module Models
    module Utils
      extend ActiveSupport::Concern

      included do
        ##############################################################################
        # Instance methods
        ##############################################################################

        #
        # Generates a new access_token and refresh_token
        #
        def refresh_token
          beyond_session = BeyondApi::Session.new(api_url: beyond_api_url, refresh_token: beyond_refresh_token)
          beyond_session.token.refresh

          update(beyond_access_token: beyond_session.access_token, 
                 beyond_refresh_token: beyond_session.refresh_token)
        end

        #
        # Generates a new access_token and refresh_token if they have expired
        #
        def refresh_token_if_needed
          token_timestamp = JWT.decode(beyond_access_token, nil, false).first['exp']
          current_timestamp = DateTime.now.to_i
          return unless token_timestamp - current_timestamp <= 3600

          refresh_token
        end

        #
        # Returns a BeyondApi::Session object with api_url, access_token and refresh_token attributes
        #
        def to_session
          BeyondApi::Session.new(api_url: beyond_api_url,
                                access_token: beyond_access_token,
                                refresh_token: beyond_refresh_token)
        end
        

        ##############################################################################
        # Class methods
        ##############################################################################

        def self.find_session(id)
          shop = find(id)
          shop.to_session
        end
      end
    end
  end
end
