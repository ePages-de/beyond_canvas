# frozen_string_literal: true

module BeyondCanvas
  class FormBuilder < ActionView::Helpers::FormBuilder # :nodoc:
    %i[email_field text_field number_field password_field text_area].each do |method|
      define_method method do |attribute, args = {}|
        field_wrapper(attribute, args) do
          super(attribute, args)
        end
      end
    end

    def select(attribute, choices, options  = {}, args = {})
      field_wrapper(attribute, args) do
        super(attribute, choices, options, args)
      end
    end

    def check_box(attribute, args = {})
      inline_wrapper(attribute, args) do
        filed_identifyer = filed_identifyer(attribute)

        args.merge!(id: filed_identifyer)
            .merge!(hidden: true)

        @template.content_tag(:div, class: 'input__checkbox') do
          super(attribute, args) +
            @template.content_tag(:label, nil, class: 'input__checkbox__control', for: filed_identifyer)
        end
      end
    end

    def radio_button(attribute, value, args = {})
      args.merge!(label: value) unless args[:label]

      inline_wrapper(attribute, args) do
        filed_identifyer = filed_identifyer(attribute)

        args.merge!(id: filed_identifyer)
            .merge!(hidden: true)

        @template.content_tag(:div, class: 'input__radio') do
          super(attribute, value, args) +
            @template.content_tag(:label, nil, class: 'input__radio__control', for: filed_identifyer)
        end
      end
    end

    def file_field(attribute, args = {})
      field_wrapper(attribute, args) do
        filed_identifyer = filed_identifyer(attribute)

        args.merge!(id: filed_identifyer)
            .merge!(hidden: true)

        custom_attributes = { data: { multiple_selection_text: '{count} files selected' } }
        args = custom_attributes.merge!(args)

        @template.content_tag(:div, class: 'input__file') do
          super(attribute, args) +
            @template.content_tag(:label,
                                  for: filed_identifyer,
                                  class: 'input__file__control button__transparent--primary') do
              args[:data][:button_text] || 'Choose file'
            end +
            @template.content_tag(:span,
                                  args[:data][:no_file_text] || 'No file chosen',
                                  class: "input__file__text #{filed_identifyer}")
        end
      end
    end

    private

    def field_wrapper(attribute, args, &block)
      label = args[:label] == false ? nil : args[:label].presence || attribute.to_s.humanize

      errors = object.errors[attribute].join(', ') if object.respond_to?(:errors) && object.errors.include?(attribute)

      @template.content_tag(:div, class: 'form__row') do
        @template.content_tag(:label, label, class: 'input__label') +
        @template.content_tag(:div, class: 'relative') do
          block.call +
            (@template.content_tag(:label, errors, class: 'input__error') if errors.present?)
        end +
        (@template.content_tag(:div, args[:hint].html_safe, class: 'input__hint') if args[:hint].present?)
      end
    end

    def inline_wrapper(attribute, args, &block)
      label = args[:label] == false ? nil : args[:label].presence || attribute.to_s.humanize

      errors = object.errors[attribute].join(', ') if object.respond_to?(:errors) && object.errors.include?(attribute)

      @template.content_tag(:div, class: 'form__row') do
        @template.content_tag(:div, class: 'relative', style: 'display: flex; align-items: center;') do
          block.call +
            @template.content_tag(:div) do
              @template.content_tag(:label, label, class: 'input__label') +
              (@template.content_tag(:div, args[:hint].html_safe, class: 'input__hint') if args[:hint].present?)
            end +
            (@template.content_tag(:label, errors, class: 'input__error') if errors.present?)
        end
      end
    end

    def filed_identifyer(attribute)
      "#{attribute}_#{DateTime.now.strftime('%Q') + rand(10_000).to_s}"
    end
  end
end
