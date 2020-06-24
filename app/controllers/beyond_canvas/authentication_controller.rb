# frozen_string_literal: true

require_dependency 'beyond_canvas/application_controller'

module BeyondCanvas
  class AuthenticationController < ApplicationController # :nodoc:
    layout 'beyond_canvas/public'

    include ::BeyondCanvas::Authentication
    include ::BeyondCanvas::ResourceManagement

    before_action :validate_app_installation_request!, only: :new

    def new
      self.resource = resource_class.new
    end

    def create
      # Search for the api url. If there is no record it creates a new record.
      resource_params = new_resource_params
      self.resource = resource_class.find_or_create_by(beyond_api_url: resource_params[:api_url])
      # Assign the attributes to the record
      if self.resource.update(resource_params)
        # Get and save access_token and refresh_token using the authentication code
        self.resource.authenticate
      else
        raise ActiveRecord::RecordNotSaved, 'Invalid Record'
      end

      redirect_to after_create_path
    end

    def update
      create
    end

    private

    def new_resource_params
      send "new_#{resource_name}_params"
    end

    def after_create_path
      new_resource_params[:return_url]
    end
  end
end
