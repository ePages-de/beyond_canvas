# frozen_string_literal: true

module BeyondCanvas
  module ApplicationHelper
    def link_to_with_icon(name = nil, options = nil, fa_class = nil, html_options = nil)
      options ||= {}

      html_options = convert_options_to_data_attributes(options, html_options)

      url = url_for(options)
      html_options['href'] ||= url

      content_tag('a', name || url, html_options) do
        (fa_class.nil? ? '' : content_tag('i', nil, class: ['link__icon ' + fa_class])) +
          name
      end
    end

    def get_flash_icon(key)
      case key
      when 'success'
        'fas fa-check'
      when 'info'
        'fas fa-info'
      when 'warning'
        'fas fa-exclamation'
      when 'error'
        'far fa-times-circle'
      else
        'fas fa-info'
      end
    end

    [:success, :info, :warning, :error].each do |method|
      define_method :"notice_#{method}" do |message|
        content_tag('div', class: "notice notice--#{method}") do
          content_tag('i', nil, class: "notice__icon #{get_flash_icon(method.to_s)}") +
            content_tag('span', message, class: 'notice__message')
        end
      end
    end

    def logo_image_tag(logo_path)
      if File.extname(logo_path) == '.svg'
        inline_svg_tag logo_path, class: 'logo', alt: 'logo'
      else
        image_tag logo_path, class: 'logo', alt: 'logo'
      end
    end
  end
end
