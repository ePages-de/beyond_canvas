# frozen_string_literal: true

module BeyondCanvas
  module FormTagHelper
    def text_area_tag(name, content = nil, options = {})
      field_wrapper(name, options) do
        super(name, content, options)
      end
    end

    def hidden_field_tag(name, value = nil, options = {})
      tag :input,
          { type: :text, name: name, id: sanitize_to_id(name),
            value: value }.update(options.stringify_keys.merge(type: :hidden))
    end

    def image_attachment_tag(blob, delete_url = nil, args = {})
      if blob
        figure_options = {
          class: ['attachment', "attachment--#{blob.representable? ? 'preview' : 'file'}",
                  "attachment--#{blob.filename.extension}"]
        }

        tag.figure(figure_options) do
          if blob.representable?
            [
              image_tag(args.present? && args[:transformations].present? ? blob.representation(args[:transformations]) : blob),
              (if delete_url.present?
                 link_to(inline_svg_tag('icons/delete.svg'), delete_url,
                         { class: 'attachment__delete-icon', method: :delete }.merge(args[:link_html_options].to_h))
               end)
            ].compact.inject(:+)
          end
        end
      end
    end

    def image_placeholder_tag(options)
      placeholder_with = 300
      placeholder_height = 300
      placeholder_with, placeholder_height = options[:size].split('x') if options[:size].present?

      figure_options = {
        class: "attachment attachment__placeholder #{options.fetch(:class, '')}",
        style: "#{options.fetch(:style, '')};width:#{placeholder_with}px;height:#{placeholder_height}px;",
        data: options[:data]
      }

      tag.figure(figure_options) do
        [
          inline_svg_tag('icons/placeholder.svg', options.fetch(:image_html_options, {}))
        ].compact.inject(:+)
      end
    end

    private

    def field_wrapper(_attribute, args, &block)
      label = sanitize(args.delete(:label))
      hint = sanitize(args.delete(:hint))
      pre = args.delete(:pre)
      post = args.delete(:post)

      tag.div(class: 'form__row') do
        [
          (tag.label(label, class: 'input__label') if label.present?),
          (tag.div(class: 'relative', style: ('display: flex;' if pre || post).to_s) do
            [
              (tag.span(pre, class: 'input__pre') if pre.present?),
              (tag.span(post, class: 'input__post') if post.present?),
              block.call
            ].compact.inject(:+)
          end),
          (tag.div(hint, class: 'input__hint') if hint.present?)
        ].compact.inject(:+)
      end
    end

    def filed_identifyer(attribute)
      "#{attribute.to_s.delete('[]')}_#{DateTime.now.strftime('%Q') + rand(10_000).to_s}"
    end
  end
end
