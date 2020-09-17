# frozen_string_literal: true

module BeyondCanvas
  class Configuration # :nodoc:
    attr_accessor :site_title, :site_logo, :favicon, :skip_webpacker, :encryption_key, :namespace, :cockpit_app,
                  :open_app_url, :preinstalled, :debug_mode

    include AssetRegistration

    def initialize
      @cockpit_app = false
      @debug_mode = false
      @encryption_key = nil
      @favicon = nil
      @namespace = '/'
      @open_app_url = nil
      @preinstalled = false
      @site_logo = nil
      @site_title = ::Rails.application.class.name.split('::').first.humanize
      @skip_webpacker = false
    end

    def setup!
      register_default_assets
    end

    private

    def register_default_assets
      register_stylesheet 'beyond_canvas.css', media: 'screen'
      register_javascript 'beyond_canvas.js'
    end
  end
end
