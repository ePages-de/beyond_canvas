# frozen_string_literal: true

require_dependency 'beyond_canvas/application_controller'

module BeyondCanvas
  class AuthenticationsController < ApplicationController # :nodoc:
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
      raise ActiveRecord::RecordNotSaved unless resource.update(resource_params)
      # Get and save access_token and refresh_token using the authentication code
      raise BeyondApi::Error if resource.authenticate.is_a?(BeyondApi::Error)

      redirect_to after_create_path
    rescue ActiveRecord::RecordNotSaved, BeyondApi::Error, StandardError => e
      logger.error "[BeyondCanvas] #{e.message}".red
      send "handle_#{e.class.name.split('::').first.underscore}_exception", e
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

    def handle_active_record_exception(_exception)
      flash[:error] = t('beyond_canvas.authentications.failure')
      render :new
    end

    def handle_beyond_api_exception(_exception)
      flash[:error] = t('beyond_canvas.authentications.failure')
      render :new
    end

    def handle_standard_error_exception(_exception)
      flash[:error] = t('beyond_canvas.authentications.failure')
      render :new
    end
  end
end
