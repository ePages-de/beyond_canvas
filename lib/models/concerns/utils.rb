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
          # Generates a new access_token and refresh_token if they have expired
          #
          def refresh_token_if_needed
            token_timestamp = decoded_jwt['exp']
            current_timestamp = DateTime.now.to_i
            return unless token_timestamp - current_timestamp <= 0

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

          #
          # Returns the shop url
          #
          def url(path = nil, params = nil)
            path = path[1..-1] if path&.chr == '/'
            "https://#{URI.parse(beyond_api_url).host}/#{path}#{'?' +params&.to_query if params.present?}"
          end

          def has_scope?(scope)
            return unless scope.include?(':')

            base, scope = scope.split(':')
            !!(decoded_jwt['scope'].find { |s| s.split(':').first == base } =~ /#{base}:.*#{scope}.*/)
          end

          ##############################################################################
          # Class methods
          ##############################################################################

          def self.find_session(id)
            shop = find(id)
            shop.to_session
          end

          private

          def decoded_jwt
            JWT.decode(beyond_access_token, nil, false).first
          end
        end
      end
    end
  end
end
