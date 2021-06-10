# frozen_string_literal: true

module BeyondCanvas
  module Models
    module Concerns
      module Webhook # :nodoc:
        extend ActiveSupport::Concern

        included do
          # Attribute accessor to generate webhook url
          attr_accessor :http_host

          ##############################################################################
          # Encrypted attribute configuration
          ##############################################################################

          attr_encrypted :beyond_shared_secret, key: [BeyondCanvas.configuration.encryption_key].pack('H*')

          ##############################################################################
          # Validations
          ##############################################################################

          # Database fields

          validates :beyond_shared_secret,
                    presence: {
                      unless: -> { encrypted_beyond_shared_secret_was.blank? }
                    }

          ##############################################################################
          # Instance methods
          ##############################################################################

          #
          # Subscribes to Beyond webhooks:
          #   * Callback URI: {APP_URL}/shops/:id/beyond_webhook
          #
          def subscribe_to_beyond_webhooks
            return if BeyondCanvas.configuration.webhook_events.to_a.empty?

            # Unsubscribe from all existing Beyond webhooks
            self.unsubscribe_from_all_beyond_webhooks
            # Create and save a signer
            self.create_signer
            # Subscribe to webhooks
            puts '_' * 150
            puts 'subscribe_to_beyond_webhooks'
            puts '_' * 150
            self.to_session.webhook_subscriptions.create(
              callback_uri: beyond_webhook_url(self.id),
              event_types: BeyondCanvas.configuration.webhook_events.to_a
            )
          end

          #
          # Unsubscribe from Beyond webhooks
          #
          def unsubscribe_from_all_beyond_webhooks
            self.refresh_token_if_needed

            session = self.to_session

            session.webhook_subscriptions.all.embedded.subscriptions.each do |webhook|
              session.webhook_subscriptions.delete(webhook.id)
            end
          end

          #
          # Update suscription from Beyond webhooks
          #
          def update_suscription_of_beyond_webhooks(callback_uri = beyond_webhook_url(self.id))
            self.refresh_token_if_needed

            session = self.to_session

            session.webhook_subscriptions.all.embedded.subscriptions.each do |webhook|
              session.webhook_subscriptions.update(webhook.id, callback_uri: callback_uri,
                                                               event_types: BeyondCanvas.configuration.webhook_events.to_a)
            end
          end


          private

          #
          # Deletes all existing signers and creates and stores a new one
          #
          def create_signer
            # Get all existing signer ids
            signer_ids = self.to_session.signers.all.embedded.signers&.map(&:id)
            # Remove the first signer if max number of signers reached to allow to create a new one
            self.to_session.signers.delete(signer_ids.slice!(0)) if signer_ids.count == 5

            # Create and save the new signer
            signer = self.to_session.signers.create
            self.update(beyond_shared_secret: signer.shared_secret)
            # Delete old signers
            signer_ids&.each { |signer_id| self.to_session.signers.delete(signer_id) }
          end

          #
          # Generates the Beyond webhook url for a given shop_id. If Rails.env is development, it uses the WEBHOOK_SITE_URL
          # environment variable. In any other case, it uses the request.env['HTTP_HOST'], that should be
          # {APP_URL}/shops/:id/beyond_webhook
          #
          def beyond_webhook_url(shop_id)
            puts '~' * 150
            puts 'beyond_webhook_url'
            puts '~' * 150
            if Rails.env.development?
              obtain_webhook_site_url
            else
              Rails.application.routes.url_helpers.beyond_webhook_shop_url(shop_id, host: http_host || ENV['HTTP_HOST'],
                                                                                    protocol: 'https')
            end
          end

          def obtain_webhook_site_url
            if BeyondCanvas.configuration.webhook_site_url.blank?
              raise 'Set BeyondCanvas.config.webhook_site_url environment variable for develpment'
            end
            puts '*' * 150
            puts 'obtain_webhook_site_url'
            puts '*' * 150

            BeyondCanvas.configuration.webhook_site_url
          end
        end
      end
    end
  end
end
