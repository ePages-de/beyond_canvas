# frozen_string_literal: true

require_dependency 'beyond_canvas/application_controller'

module BeyondCanvas
  class AuthenticationsController < ApplicationController # :nodoc:
    layout 'beyond_canvas/public'

    include ::BeyondCanvas::Authentication

    before_action :validate_app_installation_request!, only: :new

    def new
      @shop = Shop.find_or_initialize_by(beyond_api_url: params[:api_url])

      if @shop&.authenticated?
        open_app(@shop)
      elsif BeyondCanvas.configuration.preinstalled
        preinstall
      end
    end

    def install
      @shop = Shop.create_with(shop_params).create_or_find_by(beyond_api_url: params[:shop][:api_url])

      @shop.assign_attributes(shop_params)

      if @shop.save
        @shop.authenticate(params[:shop][:code])
        @shop.subscribe_to_beyond_webhooks

        redirect_to after_installation_path
      else
        render :new
      end
    end

    private

    def shop_params
      beyond_canvas_parameter_sanitizer.sanitize.merge(http_host: request.env['HTTP_HOST'])
    end

    def after_preinstallation_path
      params[:return_url]
    end

    def after_installation_path
      params[:shop][:return_url]
    end

    def after_sign_in_path
      BeyondCanvas.configuration.open_app_url
    end

    def preinstall
      @shop = Shop.create_or_find_by(beyond_api_url: params[:api_url])
      @shop.http_host = request.env['HTTP_HOST']
      @shop.authenticate(params[:code])
      @shop.subscribe_to_beyond_webhooks

      redirect_to after_preinstallation_path
    end

    def open_app(shop)
      shop.authenticate(params[:code]) if params[:code]
      reset_session
      log_in shop

      redirect_to after_sign_in_path
    end
  end
end
