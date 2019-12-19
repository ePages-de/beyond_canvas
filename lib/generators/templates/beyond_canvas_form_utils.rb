# frozen_string_literal: true

ActionView::Base.field_error_proc = Proc.new do |html_tag, instance|
  if html_tag =~ /<(input|textarea|select)/
    error_class = "input__error".freeze

    doc = Nokogiri::XML(html_tag)
    doc.children.each do |field|
      unless field["type"] == "hidden"
        unless field["class"] =~ /\berror\b/
          field["class"] = "#{field['class']} #{error_class}".strip
        end
      end
    end

    doc.to_html.html_safe
  else
    html_tag
  end
end
