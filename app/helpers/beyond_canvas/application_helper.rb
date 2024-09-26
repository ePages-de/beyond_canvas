# frozen_string_literal: true

module BeyondCanvas
  module ApplicationHelper # :nodoc:
    def full_title(page_title = '')
      base_title = BeyondCanvas.configuration.site_title

      page_title.empty? ? base_title : "#{page_title} | #{base_title}"
    end

    def logo_image_tag(logo_path, options = {})
      html_options = { class: 'logo', alt: 'logo' }.merge options

      if File.extname(logo_path) == '.svg'
        inline_svg_tag logo_path, html_options
      else
        image_tag logo_path, html_options
      end
    end
  end
end
