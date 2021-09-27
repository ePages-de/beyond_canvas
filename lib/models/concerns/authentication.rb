# frozen_string_literal: true

module BeyondCanvas
  module Models
    module Concerns
      module Authentication # :nodoc:
        extend ActiveSupport::Concern

        included do
          attr_accessor :code, :signature, :access_token_url, :api_url, :return_url

          ##############################################################################
          # Encrypted attribute configuration
          ##############################################################################

          attr_encrypted :beyond_access_token,  key: [BeyondCanvas.configuration.encryption_key].pack('H*')
          attr_encrypted :beyond_refresh_token, key: [BeyondCanvas.configuration.encryption_key].pack('H*')

          ##############################################################################
          # Validations
          ##############################################################################

          # Database fields

          validates :beyond_api_url,
                    presence: true
          validates :beyond_access_token,
                    presence: true,
                    if: -> { encrypted_beyond_access_token_was.present? }
          validates :beyond_refresh_token,
                    presence: true,
                    if: -> { encrypted_beyond_refresh_token_was.present? }

          ##############################################################################
          # Instance methods
          ##############################################################################

          #
          # Get and save access_token and refresh_token using the authentication code
          # NOTE: This method is used during the shop creation, as it is the only point
          # we know about the authentication code
          #
          def authenticate(code)
            session = BeyondApi::Session.new(api_url: beyond_api_url)

            if !Rails.env.production? && BeyondCanvas.configuration.client_credentials
              session.token.client_credentials
            else
              session.token.authorization_code(code)
            end

            update(beyond_access_token: session.access_token,
                   beyond_refresh_token: session.refresh_token)
          end

          def authenticated?
            beyond_access_token.present? &&
              (!Rails.env.production? && BeyondCanvas.configuration.client_credentials || beyond_refresh_token.present?)
          end
        end
      end
    end
  end
end
