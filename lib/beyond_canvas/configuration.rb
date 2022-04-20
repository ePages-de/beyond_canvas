# frozen_string_literal: true

module BeyondCanvas
  class Configuration # :nodoc:
    attr_accessor :site_title, :site_logo, :favicon, :skip_webpacker, :encryption_key, :namespace, :cockpit_app,
                  :open_app_url, :preinstalled, :debug_mode, :webhook_site_url, :email_logo, :client_credentials,
                  :custom_styles, :model_errors_joined_by

    include AssetRegistration
    include MenuItemRegistration
    include WebhookEventRegistration

    def initialize
      @cockpit_app = false
      @debug_mode = false
      @client_credentials = false
      @encryption_key = nil
      @favicon = nil
      @namespace = '/'
      @open_app_url = nil
      @preinstalled = false
      @site_logo = nil
      @email_logo = nil
      @site_title = ::Rails.application.class.name.split('::').first.humanize
      @skip_webpacker = false
      @custom_styles = false
      @model_errors_joined_by = ', '
    end

    def custom_styles?
      @cockpit_app || @custom_styles
    end

    def client_credentials?
      @client_credentials && !::Rails.env.production?
    end

    def setup!
      register_default_assets
      register_default_webhook_events
    end

    private

    def register_default_assets
      register_stylesheet 'beyond_canvas.css', media: 'screen'
      register_javascript 'beyond_canvas.js'
    end

    def register_default_webhook_events
      register_webhook_event('app.uninstalled')
    end
  end
end
