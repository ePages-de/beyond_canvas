# frozen_string_literal: true

module BeyondCanvas
  module Models
    module Authentication
      extend ActiveSupport::Concern

      included do
        attr_accessor :code, :signature, :access_token_url

        ##############################################################################
        # Encrypted attribute configuration
        ##############################################################################

        attr_encrypted :beyond_api_url,       key: [BeyondCanvas.configuration.encryption_key].pack('H*')
        attr_encrypted :beyond_access_token,  key: [BeyondCanvas.configuration.encryption_key].pack('H*')
        attr_encrypted :beyond_refresh_token, key: [BeyondCanvas.configuration.encryption_key].pack('H*')

        blind_index    :beyond_api_url,       key: [BeyondCanvas.configuration.blind_index_key].pack('H*')

        ##############################################################################
        # Validations
        ##############################################################################

        # Callback url params

        validates :code,
                  presence: true,
                  on: :create
        validates :signature,
                  presence: true,
                  on: :create
        validates :access_token_url,
                  presence: true,
                  on: :create

        # Database fields

        validates :beyond_api_url,
                  presence: true
        validates :beyond_access_token,
                  presence: true,
                  unless: -> { encrypted_beyond_access_token_was.blank? }
        validates :beyond_refresh_token,
                  presence: true,
                  unless: -> { encrypted_beyond_refresh_token_was.blank? }

        ##############################################################################
        # Instance methods
        ##############################################################################

        #
        # Get and save access_token and refresh_token using the authentication code
        # NOTE: This method is used during the shop creation, as it is the only point we know about the authentication code
        #
        def authenticate
          session = BeyondApi::Session.new(api_url: beyond_api_url)
          session.token.create(code)
          update(beyond_access_token: session.access_token,
                 beyond_refresh_token: session.refresh_token)
        end
      end
    end
  end
end