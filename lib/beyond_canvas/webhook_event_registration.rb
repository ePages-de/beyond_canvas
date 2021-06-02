# frozen_string_literal: true

module BeyondCanvas
  module WebhookEventRegistration # :nodoc:
    def register_webhook_event(event)
      event.is_a?(Array) ? webhooks.merge(event) : webhooks.add(event)
    end

    def webhook_events
      @webhooks ||= Set.new
    end

    def clear_webhook_events!
      webhooks.clear
    end

    alias register_webhook_events register_webhook_event
  end
end
