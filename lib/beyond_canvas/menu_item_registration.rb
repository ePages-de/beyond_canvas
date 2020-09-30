# frozen_string_literal: true

module BeyondCanvas
  module MenuItemRegistration # :nodoc:
    MenuItem = Struct.new(:name, :url, :options)

    def register_menu_item(name, url, options = {})
      menu_items.add MenuItem.new(name, url, options)
    end

    def menu_items
      @menu_items ||= Set.new
    end

    def clear_menu_items!
      menu_items.clear
    end
  end
end
