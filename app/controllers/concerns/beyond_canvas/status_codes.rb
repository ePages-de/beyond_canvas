# frozen_string_literal: true

module BeyondCanvas
  module StatusCodes # :nodoc:
    extend ActiveSupport::Concern

    private

    def bad_request
      raise ActionController::BadRequest, 'Bad Request'
    end

    def not_found
      raise ActionController::RoutingError, 'Not Found'
    end
  end
end
