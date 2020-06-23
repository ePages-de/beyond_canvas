# frozen_string_literal: true

require_dependency 'beyond_canvas/application_controller'

module BeyondCanvas
  class AuthenticationController < ApplicationController # :nodoc:
    layout 'beyond_canvas/public'

    include ::BeyondCanvas::Authentication
    include ::BeyondCanvas::ResourceManagement

    before_action :validate_app_installation_request!, only: :new
    before_action :authenticate_scope!, only: [:create, :update]

    def new
      self.resource = resource_class.new
    end

    def create
      redirect_to after_create_path
    end

    def update
      create
    end

    private

    def authenticate_scope!
      send(:"authenticate_#{resource_name}!")
      self.resource = send(:"current_#{resource_name}")
    end

    def after_create_path
      resource.return_url
    end
  end
end
