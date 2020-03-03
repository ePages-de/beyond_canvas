# frozen_string_literal: true

module BeyondCanvas
  class FormBuilder < ActionView::Helpers::FormBuilder
    def field_wrapper(attribute, args, &block)
      label = args[:label].present? ? args[:label] : attribute.to_s.humanize

      errors = object.errors[attribute].join(', ') if object.respond_to?(:errors) && object.errors.include?(attribute)

      @template.content_tag(:div, class: 'form__row') do
        @template.content_tag(:label, label, class: 'input__label') +
          @template.content_tag(:div, class: 'relative') do
            block.call +
              (@template.content_tag(:label, errors, class: 'input__error') unless errors.blank?)
          end +
          (@template.content_tag(:div, args[:hint].html_safe, class: 'input__hint') if args[:hint].present?)
      end
    end

    [:email, :text, :password, :file].each do |method|
      define_method :"#{method}_field" do |attribute, args = {}|
        field_wrapper(attribute, args) do
          super(attribute, args)
        end
      end
    end
  end
end
