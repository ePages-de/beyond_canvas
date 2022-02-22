# frozen_string_literal: true

module BeyondCanvas
  class FormBuilder < ActionView::Helpers::FormBuilder # :nodoc:
    include ActionView::Helpers::SanitizeHelper

    %i[email_field text_field number_field password_field text_area].each do |method|
      define_method method do |attribute, args = {}|
        field_wrapper(attribute, args) do
          super(attribute, args)
        end
      end
    end

    def select(attribute, choices, options = {}, args = {})
      field_wrapper(attribute, args) do
        super(attribute, choices, options, args)
      end
    end

    def check_box(attribute, args = {}, checked_value = '1', unchecked_value = '0')
      filed_identifyer = filed_identifyer(attribute)

      inline_wrapper(attribute, args, filed_identifyer) do
        args.merge!(id: filed_identifyer)
            .merge!(hidden: true)
            .merge!(class: 'input__checkbox')

        super(attribute, args, checked_value, unchecked_value) +
          @template.content_tag(:label, class: 'input__checkbox__control', for: filed_identifyer) do
            @template.inline_svg_tag('icons/checkbox_checked.svg', style: 'display: none;', class: 'input__checkbox--checked') +
            @template.inline_svg_tag('icons/checkbox_unchecked.svg', style: 'display: none;', class: 'input__checkbox--unchecked')
          end
      end
    end

    def radio_button(attribute, value, args = {})
      filed_identifyer = filed_identifyer(attribute)

      inline_wrapper(attribute, args, filed_identifyer) do
        args.merge!(id: filed_identifyer)
            .merge!(hidden: true)
            .merge!(class: 'input__radio')

        super(attribute, value, args) +
          @template.content_tag(:label, class: 'input__radio__control', for: filed_identifyer) do
            @template.inline_svg_tag('icons/radiobutton_checked.svg', style: 'display: none;', class: 'input__radio--checked') +
            @template.inline_svg_tag('icons/radiobutton_unchecked.svg', style: 'display: none;', class: 'input__radio--unchecked')
          end
      end
    end

    def file_field(attribute, args = {})
      field_wrapper(attribute, args) do
        filed_identifyer = filed_identifyer(attribute)

        args.merge!(id: filed_identifyer)
            .merge!(style: 'visibility: hidden; position: absolute;')

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

    def image_file_field(attribute, args = {}, &block)
      image_field_wrapper(attribute, args) do
        filed_identifyer = filed_identifyer(attribute)

        args.merge!(id: filed_identifyer)
            .merge!(style: 'visibility: hidden; position: absolute;')

        custom_attributes = { data: { multiple_selection_text: '{count} files selected' } }
        args = custom_attributes.merge!(args)

        placeholder_with = 300
        placeholder_height = 300

        placeholder_with, placeholder_height = args[:placeholder_size].split('x') if args[:placeholder_size].present?

        @template.content_tag(:div, class: 'attachments js-images', js_identifier: filed_identifyer) do
          image = @object.send(attribute)
          [
            (block.call if block_given?)
          ].compact.inject(:+)
          [
            (image_placeholder(args) if image.class == ActiveStorage::Attached::One && image.attachment.blank?),
            (image_placeholder(args) if image.class == ActiveStorage::Attached::Many && image.attachments.blank?)
          ].compact.inject(:+)
        end +
        @template.content_tag(:div, class: 'input__file', style: 'margin-top: 16px') do
          @template.file_field(@object_name, attribute, args) +
          @template.content_tag(:label,
                                for: filed_identifyer,
                                class: 'input__file__control button__transparent--primary') do
            args[:data][:button_text] || 'Upload image'
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

      errors = object.errors[attribute].join(', ') if object.respond_to?(:errors) && object.errors.include?(attribute)

      @template.content_tag(:div, class: 'form__row') do
        [
          (@template.content_tag(:label, label, class: 'input__label') if label.present?),
          (@template.content_tag(:div, class: 'relative', style: "#{'display: flex;' if pre || post}") do
            [
              (@template.content_tag(:span, pre, class: 'input__pre') if pre.present?),
              (@template.content_tag(:span, post, class: 'input__post') if post.present?),
              block.call,
              (@template.content_tag(:label, errors, class: 'input__error') if errors.present?)
            ].compact.inject(:+)
          end),
          (@template.content_tag(:div, hint, class: 'input__hint') if hint.present?)
        ].compact.inject(:+)
      end
    end

    def image_field_wrapper(attribute, args, &block)
      label = sanitize(args.delete(:label))
      hint = sanitize(args.delete(:hint))
      pre = args.delete(:pre)
      post = args.delete(:post)

      errors = object.errors[attribute].join(', ') if object.respond_to?(:errors) && object.errors.include?(attribute)

      @template.content_tag(:div, class: 'form__row') do
        [
          (@template.content_tag(:label, label, class: 'input__label') if label.present?),
          (@template.content_tag(:div, hint, class: 'input__hint', style: 'margin-bottom: 10x') if hint.present?),
          (@template.content_tag(:div, class: 'relative', style: "#{'display: flex;' if pre || post}") do
            [
              (@template.content_tag(:span, pre, class: 'input__pre') if pre.present?),
              (@template.content_tag(:span, post, class: 'input__post') if post.present?),
              block.call,
              (@template.content_tag(:label, errors, class: 'input__error') if errors.present?)
            ].compact.inject(:+)
          end),
        ].compact.inject(:+)
      end
    end

    def inline_wrapper(attribute, args, filed_identifyer, &block)
      label = sanitize(args.delete(:label))
      hint = sanitize(args.delete(:hint))
      errors = object.errors[attribute].join(', ') if object.respond_to?(:errors) && object.errors.include?(attribute)

      @template.content_tag(:div, class: 'form__row') do
        @template.content_tag(:div, class: 'relative', style: 'display: flex; align-items: center;') do
          block.call +
            (@template.content_tag(:div) do
              [
                (@template.content_tag(:label, label, class: "input__label", for: filed_identifyer) if label.present?),
                (@template.content_tag(:label, hint, class: 'input__hint', for: filed_identifyer) if hint.present?)
              ].compact.inject(:+)
            end if label.present? || hint.present?) +
            (@template.content_tag(:label, errors, class: 'input__error') if errors.present?)
        end
      end
    end

    def filed_identifyer(attribute)
      "#{attribute}_#{DateTime.now.strftime('%Q') + rand(10_000).to_s}"
    end

    def image_placeholder(args)
      placeholder_with = 300
      placeholder_height = 300
      placeholder_with, placeholder_height = args[:placeholder_size].split('x') if args[:placeholder_size].present?

      @template.inline_svg_tag('icons/placeholder.svg', class: 'attachment', style: "width:#{placeholder_with}px;height:#{placeholder_height}px;")
    end
  end
end
