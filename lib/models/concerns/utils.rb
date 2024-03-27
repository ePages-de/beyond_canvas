# frozen_string_literal: true

require 'jwt'

module BeyondCanvas
  module Models
    module Concerns
      module Utils # :nodoc:
        extend ActiveSupport::Concern

        included do
          ##############################################################################
          # Instance methods
          ##############################################################################

          #
          # Retrieves new access_token and refresh_token and stores them.
          #
          def refresh_token
            session = BeyondApi::Session.new(api_url: beyond_api_url, refresh_token: beyond_refresh_token)

            if BeyondCanvas.configuration.client_credentials?
              session.token.client_credentials
            else
              session.token.refresh_token
            end

            update(beyond_access_token: session.access_token,
                   beyond_refresh_token: session.refresh_token)
          end

          #
          # Checks if the beyond_access_token has expired. If so, calls refresh_token in order to get a new
          # access_token (and refresh_token if applies) and stores it.
          #
          def refresh_token_if_needed
            token_timestamp = decoded_jwt['exp']
            current_timestamp = DateTime.now.to_i

            return unless token_timestamp - current_timestamp <= 0

            refresh_token
          end

          #
          # Returns a BeyondApi::Session object (with `api_url`, `access_token` and `refresh_token`
          # attributes) from the instantiated Shop.
          #
          def to_session
            refresh_token_if_needed unless BeyondCanvas.configuration.client_credentials

            BeyondApi::Session.new(api_url: beyond_api_url,
                                   access_token: beyond_access_token,
                                   refresh_token: beyond_refresh_token)
          end

          #
          # Returns the shop url
          #
          def url(path = nil, params = nil)
            path = path[1..-1] if path&.chr == '/'

            "https://#{URI.parse(beyond_api_url).host}/#{path}#{'?' +params&.to_query if params.present?}"
          end

          #
          # Checks if the decoded access token has the given scope.
          #
          def has_scope?(scope)
            return unless scope.include?(':')

            base, scope = scope.split(':')

            !!(decoded_jwt['scope'].find { |s| s.split(':').first == base } =~ /#{base}:.*#{scope}.*/)
          end

          ##############################################################################
          # Class methods
          ##############################################################################

          #
          # Searches for a Shop based on its UUID and returns it's BeyondApi::Session object.
          #
          def self.find_session(id)
            find(id)&.to_session
          end

          ##############################################################################
          # Private methods
          ##############################################################################

          private

          #
          # Returns the decoded version of the @beyond_access_token.
          #
          def decoded_jwt
            JWT.decode(beyond_access_token, nil, false).first
          end
        end
      end
    end
  end
end
