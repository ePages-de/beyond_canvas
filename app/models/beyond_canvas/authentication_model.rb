# frozen_string_literal: true

module BeyondCanvas
  class AuthenticationModel < ApplicationRecord
    self.table_name = BeyondCanvas.configuration.auth_model.pluralize

    attr_accessor :code, :signature, :return_url, :api_url, :access_token_url

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
    validates :return_url,
              presence: true,
              on: :create
    validates :api_url,
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
    # Updates the shop with the given access_token and refresh_token
    #
    def update_token(access_token, refresh_token)
      update(beyond_access_token: access_token, beyond_refresh_token: refresh_token)
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
    # Get and save access_token and refresh_token using the authentication code
    # NOTE: This method is used during the shop creation, as it is the only point we know about the authentication code
    #
    def authenticate
      session = BeyondApi::Session.new(api_url: beyond_api_url)
      session.token.create(code)
      update_token(session.access_token, session.refresh_token)
    end

    #
    # Returns beyond_api_url without 'https://' and '/api'
    #
    def name
      beyond_api_url.gsub('https://', '').gsub('/api', '')
    end

    def refresh_token
      token_timestamp = JWT.decode(beyond_access_token, nil, false).first['exp']
      current_timestamp = DateTime.now.to_i
      return unless token_timestamp - current_timestamp <= 3600

      beyond_session = BeyondApi::Session.new(api_url: beyond_api_url, refresh_token: beyond_refresh_token)
      beyond_session.token.refresh

      update_token(beyond_session.access_token, beyond_session.refresh_token)
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