class BeyondFormBuilder < ActionView::Helpers::FormBuilder
  def field_wrapper(attribute, args, &block)
    label = args[:label].present? ? args[:label] : attribute.to_s.humanize
    @template.content_tag(:div, class: 'form__row') do
      @template.content_tag(:label, label, class: 'input__label') +
      @template.content_tag(:div, class: 'relative') do
        block.call
      end +
      (@template.content_tag(:div, args[:hint], class: 'input__hint') if args[:hint].present?)
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
