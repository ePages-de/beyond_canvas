# frozen_string_literal: true

module BeyondCanvas
  class Configuration # :nodoc:
    attr_accessor :site_title, :site_logo, :favicon, :skip_webpacker

    include AssetRegistration

    def initialize
      @site_title = ::Rails.application.class.name.split('::').first.humanize
      @site_logo = nil
      @favicon = nil
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
