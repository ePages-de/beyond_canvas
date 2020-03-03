# frozen_string_literal: true

ActionView::Base.field_error_proc = proc do |html_tag, _instance|
  if html_tag =~ /<(input|textarea|select)/
    error_class = 'input__error'

    doc = Nokogiri::XML(html_tag)
    doc.children.each do |field|
      next if field['type'] == 'hidden'

      next if field['class'] =~ /\berror\b/

      field['class'] = "#{field['class']} #{error_class}".strip
    end

    doc.to_html.html_safe
  else
    html_tag
  end
end
