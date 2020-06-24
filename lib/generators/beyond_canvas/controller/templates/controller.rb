# frozen_string_literal: true

class <%= scope.camelize %>Controller < BeyondCanvas::AuthenticationsController
  # before_action :configure_params, only: [:create]

  # def new
  #   super
  # end

  # def create
  #   super
  # end

  # private

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_params
  #   beyond_canvas_parameter_sanitizer.permit(:attribute1, :attribute2)
  # end

  # The path used after creating the shop in the database
  # def after_create_path
  #   resource.return_url
  # end

  # def handle_active_record_exception(exception)
  #   super
  # end

  # def handle_beyond_api_exception(exception)
  #   super
  # end

  # def handle_standard_error_exception(exception)
  #   super
  # end
end
