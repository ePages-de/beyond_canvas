module BeyondCanvas
  module StatusCodes
    extend ActiveSupport::Concern

    private

    def bad_request
      raise ActionController::BadRequest.new 'Bad Request'
    end

    def not_found
      raise ActionController::RoutingError.new 'Not Found'
    end
  end
end
