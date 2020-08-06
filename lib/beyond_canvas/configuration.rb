# frozen_string_literal: true

module BeyondCanvas
  class Configuration # :nodoc:
    attr_accessor :site_title, :site_logo, :favicon, :skip_webpacker, :encryption_key, :blind_index_key, :namespace,
                  :cockpit_app

    include AssetRegistration

    def initialize
      @blind_index_key = nil
      @cockpit_app = false
      @encryption_key = nil
      @favicon = nil
      @namespace = '/'
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
