# frozen_string_literal: true

require_dependency 'beyond_canvas/application_controller'

module BeyondCanvas
  class WebhooksController < ApplicationController # :nodoc:
    skip_before_action :verify_authenticity_token

    include ::BeyondCanvas::RequestValidation
    include ::BeyondCanvas::StatusCodes

    before_action :set_shop, only: [:webhook]

    if Rails.env.production?
      before_action only: [:webhook] do
        signature = request.headers['x-epages-signature']
        bad_request unless valid_signature?(signature, signature_params, @shop.beyond_shared_secret)
      end
    end

    def webhook
      begin
        if @shop
          body = JSON.parse(request.body.read)
          event = request.headers.env['HTTP_X_EPAGES_WEBHOOK_EVENT_TYPE'].gsub('.', '_')
          method = "handle_#{event}"
          send method, body
        end
      rescue JSON::ParserError
        render(json: { status: 400, error: 'Invalid payload' }) && (return)
      rescue NoMethodError
        render(json: { status: 500, message: 'https://github.com/ePages-de/beyond_canvas/wiki' }) && (return)
      end
      render json: { status: 200 }
    end

    private

    def handle_app_uninstalled(_data)
      puts '*' * 75
      puts 'handle_app_uninstalled'
      puts '*' * 75
      @shop.delete_beyond_webhooks_subscriptions
      @shop.destroy
    end

    def set_shop
      @shop = Shop.find(params[:id])
      @shop.refresh_token_if_needed
    end
  end
end
