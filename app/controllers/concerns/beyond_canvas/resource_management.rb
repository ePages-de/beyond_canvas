# frozen_string_literal: true

module BeyondCanvas
  module ResourceManagement # :nodoc:
    extend ActiveSupport::Concern

    included do
      # Share some methods defined in the controller to make them available for the view
      if respond_to?(:helper_method)
        helpers = %w(resource resource_name resource_class)
        helper_method(*helpers)
      end
    end

    private

    def resource_name
      BeyondCanvas.auth_model
    end

    def resource
      instance_variable_get(:"@#{resource_name}")
    end

    def resource=(new_resource)
      instance_variable_set(:"@#{resource_name}", new_resource)
    end

    def resource_class
      resource_name.classify.constantize
    end
  end
end
