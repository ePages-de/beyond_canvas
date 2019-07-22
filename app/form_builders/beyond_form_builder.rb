class BeyondFormBuilder < ActionView::Helpers::FormBuilder
  def field_wrapper(attribute, args, &block)
    label = args[:label].present? ? args[:label] : attribute.to_s.humanize

    if self.object.respond_to?(:errors) && self.object.errors.include?(attribute)
      errors = self.object.errors[attribute].join(", ")
    end

    @template.content_tag(:div, class: 'form__row') do
      @template.content_tag(:label, label, class: 'input__label') +
      @template.content_tag(:div, class: 'relative') do
        block.call +

        (@template.content_tag(:label, errors, class: "input__errors") unless errors.blank?)
      end +
      (@template.content_tag(:div, args[:hint].html_safe, class: 'input__hint') if args[:hint].present?)
    end
  end

  def email_field(attribute, args = {})
    field_wrapper(attribute, args) do
      super(attribute, args)
    end
  end

  def text_field(attribute, args = {})
    field_wrapper(attribute, args) do
      super(attribute, args)
    end
  end

  def password_field(attribute, args = {})
    field_wrapper(attribute, args) do
      super(attribute, args)
    end
  end
end
