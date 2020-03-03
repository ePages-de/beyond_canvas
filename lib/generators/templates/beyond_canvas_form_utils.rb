# frozen_string_literal: true

# Adds form__error class to the inputs after sending a form when errors
ActionView::Base.field_error_proc = proc do |html_tag, _instance|
  include ActionView::Helpers::SanitizeHelper

  if html_tag =~ /<(input|textarea|select)/
    error_class = 'form__error'

    doc = Nokogiri::XML(html_tag)
    doc.children.each do |field|
      next if field['type'] == 'hidden'

      next if field['class'] =~ /\berror\b/

      field['class'] = "#{field['class']} #{error_class}".strip
    end

    sanitize doc.to_html
  else
    html_tag
  end
end
