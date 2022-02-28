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
      filed_identifyer = filed_identifyer(name)

      inline_wrapper(name, options, filed_identifyer) do

        options.merge!(id: filed_identifyer)
               .merge!(hidden: true)
               .merge!(class: 'input__checkbox')

        super(name, value, checked, options) +
          content_tag(:label, class: 'input__checkbox__control', for: filed_identifyer) do
            inline_svg_tag('icons/checkbox_checked.svg', style: 'display: none;', class: 'input__checkbox--checked') +
            inline_svg_tag('icons/checkbox_unchecked.svg', style: 'display: none;', class: 'input__checkbox--unchecked')
          end
      end
    end

    def radio_button_tag(name, value, checked = false, options = {})
      filed_identifyer = filed_identifyer(name)

      inline_wrapper(name, options, filed_identifyer) do

        options.merge!(id: filed_identifyer)
               .merge!(hidden: true)
               .merge!(class: 'input__radio')

        super(name, value, checked, options) +
          content_tag(:label, class: 'input__radio__control', for: filed_identifyer) do
            inline_svg_tag('icons/radiobutton_checked.svg', style: 'display: none;', class: 'input__radio--checked') +
            inline_svg_tag('icons/radiobutton_unchecked.svg', style: 'display: none;', class: 'input__radio--unchecked')
          end
      end
    end

    def toggle_tag(name, value = 1, checked = false, options = {})
      filed_identifyer = filed_identifyer(name)

      inline_wrapper(name, options, filed_identifyer) do

        options.merge!(id: filed_identifyer)
               .merge!(hidden: true)
               .merge!(class: 'input__toggle')

        html_options = { type: 'checkbox', name: name, value: value }.update(options.stringify_keys)
        html_options['checked'] = 'checked' if checked

        tag(:input, html_options) +
          content_tag(:label, class: 'input__toggle__control', for: filed_identifyer) do
            inline_svg_tag('icons/toggle.svg')
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

    def image_attachment_tag(blob, delete_url = nil, args = {})
      if blob
        content_tag(:figure, class: "attachment attachment--#{blob.representable? ? 'preview' : 'file'} attachment--#{blob.filename.extension}") do
          if blob.representable?
            [
              (image_tag(args.present? && args[:transformations].present? ? blob.representation(args[:transformations]) : blob)),
              (link_to(inline_svg_tag('icons/delete.svg'), delete_url, {class: 'attachment__delete-icon', method: :delete}.merge(args[:link_html_options].to_h)) unless delete_url.blank?)
            ].compact.inject(:+)
          end
        end
      end
    end

    private

    def field_wrapper(attribute, args, &block)
      label = sanitize(args.delete(:label))
      hint = sanitize(args.delete(:hint))
      pre = args.delete(:pre)
      post = args.delete(:post)

      content_tag(:div, class: 'form__row') do
        [
          (content_tag(:label, label, class: 'input__label') if label.present?),
          (content_tag(:div, class: 'relative', style: "#{'display: flex;' if pre || post}") do
            [
              (content_tag(:span, pre, class: 'input__pre') if pre.present?),
              (content_tag(:span, post, class: 'input__post') if post.present?),
              block.call
            ].compact.inject(:+)
          end),
          (content_tag(:div, hint, class: 'input__hint') if hint.present?)
        ].compact.inject(:+)
      end
    end

    def inline_wrapper(attribute, args, filed_identifyer, &block)
      label = sanitize(args.delete(:label))
      hint = sanitize(args.delete(:hint))

      content_tag(:div, class: 'form__row') do
        content_tag(:div, class: 'relative', style: 'display: flex; align-items: center;') do
          block.call +
            (content_tag(:div) do
              [
                (content_tag(:label, label, class: "input__label", for: filed_identifyer) if label.present?),
                (content_tag(:label, hint, class: 'input__hint', for: filed_identifyer) if hint.present?)
              ].compact.inject(:+)
            end if label.present? || hint.present?)
        end
      end
    end

    def filed_identifyer(attribute)
      "#{attribute.to_s.delete('[]')}_#{DateTime.now.strftime('%Q') + rand(10_000).to_s}"
    end
  end
end
