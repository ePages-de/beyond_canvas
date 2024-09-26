# frozen_string_literal: true

module BeyondCanvas
  module ApplicationHelper # :nodoc:
    def full_title(page_title = '')
      base_title = BeyondCanvas.configuration.site_title

      page_title.empty? ? base_title : "#{page_title} | #{base_title}"
    end

    def logo_image_tag(logo_path, options = {})
      html_options = { class: 'logo', alt: 'logo' }.merge options

      if File.extname(logo_path) == '.svg'
        inline_svg_tag logo_path, html_options
      else
        image_tag logo_path, html_options
      end
    end

    def collapse(name, html_options = nil, &block)
      html_options ||= {}
      id = unique_id(:collapse)

      html_options.merge!(class: 'collapse__content') { |_key, old_val, new_val| [new_val, old_val].join(' ') }
      html_options.merge!(id: id)

      content_tag('div', class: 'collapse') do
        content_tag('a', class: 'collapse__button', title: name, data: { visible: false, toggle: 'collapse', target: "##{id}" }) do
          inline_svg_tag('icons/arrow_right.svg', class: 'collapse__icon') + name
        end +
          content_tag('div', html_options) do
            yield block if block_given?
          end
      end
    end

    def step_list(title = nil, steps: [])
      content_tag('div', class: 'step-list__container') do
        [
          (content_tag('h4', raw(title), class: 'step-list__title') if title.present?),
          content_tag('table', class: 'step-list__items') do
            content_tag('tbody') do
              safe_join(steps.each_with_index.collect do |step, index|
                content_tag('tr') do
                  content_tag('td', class: 'step-list__bubble-column') do
                    content_tag('div', index + 1, class: 'step-list__bubble')
                  end +
                    content_tag('td') do
                      content_tag('strong', raw(step[:headline]), class: 'step-list__headline') +
                        content_tag('p', raw(step[:description]), class: 'step-list__description')
                    end
                end
              end)
            end
          end
        ].compact.inject(:+)
      end
    end

    private

    def unique_id(attribute)
      "#{attribute}_#{DateTime.now.strftime('%Q') + rand(10_000).to_s}"
    end
  end
end
