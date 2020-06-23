# frozen_string_literal: true

class <%= scope.camelize %>Controller < BeyondCanvas::AuthenticationController
  # before_action :configure_params, only: [:create, :update]

  # def new
  #   super
  # end

  # def create
  #   super
  # end

  # def update
  #   super
  # end

  # private

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_params
  #   devise_parameter_sanitizer.permit(:attribute1, :attribute2)
  # end

  # The path used after creating the shop in the database
  # def after_create_path
  #   new_shop_params[:return_url]
  # end

  # The path used after updating the shop in the database
  # def after_update_path
  #   new_shop_params[:return_url]
  # end
end
