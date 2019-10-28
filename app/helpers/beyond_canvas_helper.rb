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
    when 'success'
      "fas fa-check"
    when 'notice'
      "fas fa-info"
    when 'warning'
      "fas fa-exclamation"
    when 'error'
      "far fa-times-circle"
    else
      "fas fa-info"
    end
  end
end
