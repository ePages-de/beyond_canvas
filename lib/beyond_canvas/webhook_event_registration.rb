# frozen_string_literal: true

module BeyondCanvas
  module WebhookEventRegistration # :nodoc:
    def register_webhook_event(event)
      event.is_a?(Array) ? webhook_events.merge(event) : webhook_events.add(event)
    end

    def webhook_events
      @webhook_events ||= Set.new
    end

    def clear_webhook_events!
      webhook_events.clear
    end

    alias register_webhook_events register_webhook_event
  end
end
