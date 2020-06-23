# frozen_string_literal: true

module BeyondCanvas
  module Models
    module Shop
      extend ActiveSupport::Concern
      include BeyondCanvas::Models::Authentication
      include BeyondCanvas::Models::Utils

      included do
        attr_accessor :api_url, :return_url

        ##############################################################################
        # Validations
        ##############################################################################

        # Callback url params

        validates :api_url,
                  presence: true,
                  on: :create
        validates :return_url,
                  presence: true,
                  on: :create
      end
    end
  end
end
