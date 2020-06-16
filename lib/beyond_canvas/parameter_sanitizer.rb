# frozen_string_literal: true

module BeyondCanvas
  class ParameterSanitizer
    DEFAULT_PERMITTED_ATTRIBUTES = [:code, :signature, :return_url, :api_url, :access_token_url]

    def initialize(resource_name, params)
      @params         = params
      @resource_name  = resource_name
      @permitted      = DEFAULT_PERMITTED_ATTRIBUTES
    end

    def sanitize
      permit_keys(default_params)
    end

    def permit(*keys)
      @permitted.concat(keys)
    end

    private

    def default_params
      if hashable_resource_params?
        @params.fetch(@resource_name)
      else
        empty_params
      end
    end

    def hashable_resource_params?
      @params[@resource_name].respond_to?(:permit)
    end

    def empty_params
      ActionController::Parameters.new({})
    end

    def permit_keys(parameters)
      parameters.permit(*@permitted)
    end
  end
end
