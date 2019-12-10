# frozen_string_literal: true

module BeyondCanvasHelper
  def link_to_with_icon(name = nil, options = nil, fa_icon_class = nil, html_options = nil)
    options ||= {}

    html_options = convert_options_to_data_attributes(options, html_options)

    url = url_for(options)
    html_options["href".freeze] ||= url

    content_tag("a".freeze, name || url, html_options) do
      (fa_icon_class.nil? ? "" : content_tag("i".freeze, nil, class: ["link__icon " + fa_icon_class])) +
      name
    end
  end

  def get_flash_icon(key)
    case key
    when "success"
      "fas fa-check"
    when "info"
      "fas fa-info"
    when "warning"
      "fas fa-exclamation"
    when "error"
      "far fa-times-circle"
    else
      "fas fa-info"
    end
  end

  [:success, :info, :warning, :error].each do |method|
    define_method :"notice_#{method}" do |message|
      content_tag("div".freeze, class: "notice notice--#{method}") do
        content_tag("i".freeze, nil, class: "notice__icon #{get_flash_icon(method.to_s)}") +
        content_tag("span".freeze, message, class: "notice__message")
      end
    end
  end

  def logo_image_tag(logo)
    if logo =~ URI::regexp
      image_tag logo, class: "logo"
    else
      image_tag File.basename(logo), class: "logo"
    end
  end
end
