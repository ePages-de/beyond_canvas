# frozen_string_literal: true

module BeyondCanvas
  class FormBuilder < ActionView::Helpers::FormBuilder # :nodoc:
    def field_wrapper(attribute, args, options = {}, &block)
      label = args[:label].presence || attribute.to_s.humanize

      errors = object.errors[attribute].join(', ') if object.respond_to?(:errors) && object.errors.include?(attribute)

      @template.content_tag(:div, class: 'form__row') do
        (options[:hide_label] ? @template.tag.i : @template.content_tag(:label, label, class: 'input__label')) +
        @template.content_tag(:div, class: 'relative') do
          block.call +
            (@template.content_tag(:label, errors, class: 'input__error') if errors.present?)
        end +
        (@template.content_tag(:div, args[:hint].html_safe, class: 'input__hint') if args[:hint].present?)
      end
    end

    %i[email text number password].each do |method|
      define_method :"#{method}_field" do |attribute, args = {}|
        field_wrapper(attribute, args) do
          super(attribute, args)
        end
      end
    end

    def check_box(attribute, args = {})
      label = args[:label].presence || attribute.to_s.humanize

      field_wrapper(attribute, args, hide_label: true) do
        filed_identifyer = "#{attribute}_#{(Time.now.to_f * 1000).to_i}"

        args.merge!(id: filed_identifyer)
            .merge!(hidden: true)

        @template.content_tag(:div, class: 'input__checkbox') do
          super(attribute, args) +
            @template.content_tag(:label, nil, class: 'input__checkbox__label', for: filed_identifyer) +
            @template.content_tag(:label, label, class: 'input__label', for: filed_identifyer)
        end
      end
    end

    def file_field(attribute, args = {})
      field_wrapper(attribute, args) do
        filed_identifyer = "#{attribute}_#{(Time.now.to_f * 1000).to_i}"

        args.merge!(id: filed_identifyer)
            .merge!(hidden: true)

        custom_attributes = { data: { multiple_selection_text: '{count} files selected' } }
        args = custom_attributes.merge!(args)

        @template.content_tag(:div, class: 'input__file') do
          super(attribute, args) +
            @template.content_tag(:label,
                                  for: filed_identifyer,
                                  class: 'input__file__label button__transparent--primary') do
              args[:data][:button_text] || 'Choose file'
            end +
            @template.content_tag(:span,
                                  args[:data][:no_file_text] || 'No file chosen',
                                  class: "input__file__text #{filed_identifyer}")
        end
      end
    end
  end
end
