# frozen_string_literal: true

module BeyondCanvas
  module Models
    module Concerns
      module Webhook # :nodoc:
        extend ActiveSupport::Concern

        included do
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
          # Deletes all existing signers and creates and stores a new one
          #
          def create_signer
            # Get all existing signer ids
            signer_ids = self.to_session.signers.all.embedded.signers&.map(&:id)
            # Create and save the new signer
            signer = self.to_session.signers.create
            self.update(beyond_shared_secret: signer.shared_secret)
            # Delete old signers
            signer_ids&.each { |signer_id| self.to_session.signers.delete(signer_id) }
          end

          #
          # Subscribes to Beyond webhooks:
          #   * Callback URI: {APP_URL}/shops/:id/beyond_webhook
          #
          def subscribe_to_beyond_webhooks
            # Unsubscribe from Beyond webhooks
            delete_beyond_webhooks_subscriptions

            self.to_session.webhook_subscriptions.create(
              callback_uri: beyond_webhook_url(self.id),
              event_types: DEFAULT_WEBHOOK_EVENT_TYPES.concat(BeyondCanvas.configuration.webhook_event_types || [])
            )
          end

          #
          # Unsubscribe from Beyond webhooks
          #
          def delete_beyond_webhooks_subscriptions
            self.refresh_token_if_needed

            session = self.to_session

            session.webhook_subscriptions.all.embedded.subscriptions.each do |webhook|
              session.webhook_subscriptions.delete(webhook.id)
            end
          end

          private

          #
          # Generates the Beyond webhook url for a given shop_id. If Rails.env is development, it uses the WEBHOOK_SITE_URL
          # environment variable. In any other case, it uses the request.env['HTTP_HOST'], that should be
          # {APP_URL}/shops/:id/beyond_webhook
          #
          def beyond_webhook_url(shop_id)
            if Rails.env.development?
              obtain_webhook_site_url
            else
              Rails.application.routes.url_helpers.beyond_webhook_shop_url(shop_id, host: http_host,
                                                                                    protocol: 'https')
            end
          end

          def obtain_webhook_site_url
            if BeyondCanvas.config.webhook_site_url.blank?
              raise 'Set BeyondCanvas.config.webhook_site_url environment variable for develpment'
            end

            BeyondCanvas.config.webhook_site_url
          end
        end
      end
    end
  end
end
