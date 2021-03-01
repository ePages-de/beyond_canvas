# frozen_string_literal: true

module BeyondCanvas
  module FormTagHelper
    %i[email_field_tag text_field_tag password_field_tag text_area_tag].each do |method|
      define_method method do |name, value = nil, options = {}|
        field_wrapper(name, options) do
          super(name, value, options)
        end
      end
    end

    def select_tag(name, option_tags = nil, options = {})
      field_wrapper(name, options) do
        super(name, option_tags, options)
      end
    end

    def check_box_tag(name, value = 1, checked = false, options = {})
      options.merge!(label: name) unless options[:label]

      inline_wrapper(name, options) do
        filed_identifyer = filed_identifyer(name)

        options.merge!(id: filed_identifyer)
               .merge!(hidden: true)

        content_tag(:div, class: 'input__checkbox') do
          super(name, value, checked, options) +
            content_tag(:label, nil, class: 'input__checkbox__control', for: filed_identifyer)
        end
      end
    end

    def toggle_tag(name, value = 1, checked = false, options = {})
      options.merge!(label: name) unless options[:label]

      inline_wrapper(name, options) do
        filed_identifyer = filed_identifyer(name)

        options.merge!(id: filed_identifyer)
               .merge!(hidden: true)

        html_options = { type: 'checkbox', name: name, value: value }.update(options.stringify_keys)
        html_options['checked'] = 'checked' if checked

        content_tag(:div, class: 'input__toggle') do
          tag(:input, html_options) +
            content_tag(:label, nil, class: 'input__toggle__control', for: filed_identifyer)
        end
      end
    end

    def radio_button_tag(name, value, checked = false, options = {})
      options.merge!(label: value) unless options[:label]

      inline_wrapper(name, options) do
        filed_identifyer = filed_identifyer(name)

        options.merge!(id: filed_identifyer)
               .merge!(hidden: true)

        content_tag(:div, class: 'input__radio') do
          super(name, value, checked, options) +
            content_tag(:label, nil, class: 'input__radio__control', for: filed_identifyer)
        end
      end
    end

    def hidden_field_tag(name, value = nil, options = {})
      tag :input, { type: :text, name: name, id: sanitize_to_id(name), value: value }.update(options.stringify_keys.merge(type: :hidden))
    end

    def number_field_tag(name, value = nil, options = {})
      field_wrapper(name, options) do
        options = options.stringify_keys
        if (range = options.delete('in') || options.delete('within'))
          options.update(min: range.min, max: range.max)
        end
        tag :input, { type: 'number', name: name, id: sanitize_to_id(name), value: value }.update(options.stringify_keys)
      end
    end

    private

    def field_wrapper(attribute, args, &block)
      label = args[:label] == false ? nil : args[:label].presence || attribute.to_s.humanize

      content_tag(:div, class: 'form__row') do
        content_tag(:label, label, class: 'input__label') +
          content_tag(:div, class: 'relative') do
            block.call
          end +
          (content_tag(:div, args[:hint].html_safe, class: 'input__hint') if args[:hint].present?)
      end
    end

    def inline_wrapper(attribute, args, &block)
      label = args[:label] == false ? nil : args[:label].presence || attribute.to_s.humanize

      content_tag(:div, class: 'form__row') do
        content_tag(:div, class: 'relative', style: 'display: flex; align-items: center;') do
          block.call +
            content_tag(:div) do
              content_tag(:label, label, class: 'input__label') +
                (content_tag(:div, args[:hint].html_safe, class: 'input__hint') if args[:hint].present?)
            end
        end
      end
    end

    def filed_identifyer(attribute)
      "#{attribute.delete('[]')}_#{DateTime.now.strftime('%Q') + rand(10_000).to_s}"
    end
  end
end
