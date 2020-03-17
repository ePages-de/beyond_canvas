# frozen_string_literal: true

module BeyondCanvas
  module ApplicationHelper
    def full_title(page_title = '')
      if I18n.exists?('app_name')
        base_title = I18n.t('app_name')
      else
        logger.debug "[BeyondCanvas] Missing translation: #{I18n.locale}.app_name".yellow
        base_title = File.basename(Rails.root).humanize
      end

      page_title.empty? ? base_title : page_title + ' | ' + base_title
    end

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

    [:success, :info, :warning, :error].each do |method|
      define_method :"notice_#{method}" do |name = nil, html_options = nil, &block|
        notice_render(method, name, html_options, &block)
      end
    end

    def logo_image_tag(logo_path)
      if File.extname(logo_path) == '.svg'
        inline_svg_tag logo_path, class: 'logo', alt: 'logo'
      else
        image_tag logo_path, class: 'logo', alt: 'logo'
      end
    end

    private

    def get_flash_icon(key)
      case key
      when 'success'
        'fas fa-check'
      when 'info'
        'fas fa-info-circle'
      when 'warning'
        'fas fa-exclamation-circle'
      when 'error'
        'far fa-times-circle'
      else
        'fas fa-info'
      end
    end

    def notice_render(method, name = nil, html_options = nil, &block)
      html_options, name = name, block if block_given?

      html_options ||= {}

      html_options.merge!(class: "notice notice--#{method}") { |key, old_val, new_val| [new_val, old_val].join(' ') }

      content_tag('div', html_options) do
        content_tag('i', nil, class: "notice__icon #{get_flash_icon(method.to_s)}") +
        content_tag('span', block_given? ? capture(&name) : name, class: 'notice__content')
      end
    end
  end
end
