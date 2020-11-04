# frozen_string_literal: true

module BeyondCanvas
  module StatusesHelper # :nodoc:
    %i[good warning danger neutral].each do |method|
      define_method :"status_#{method}" do |name = nil, html_options = nil, &block|
        status_render(method, name, html_options, &block)
      end
    end

    private

    def status_render(method, name = nil, html_options = nil, &block)
      if block_given?
        html_options = name
        name = block
      end

      html_options ||= {}

      html_options.merge!(class: "status status--#{method}") { |_key, old_val, new_val| [new_val, old_val].join(' ') }

      content_tag('span', block_given? ? capture(&name) : name, html_options)
    end
  end
end
