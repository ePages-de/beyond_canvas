# frozen_string_literal: true

module BeyondCanvas
  module StatusCodes # :nodoc:
    extend ActiveSupport::Concern

    included do
      before_action :check_session # rubocop:disable Rails/LexicallyScopedActionFilter
    end

    private

    def bad_request
      raise ActionController::BadRequest, 'Bad Request'
    end

    def not_found
      raise ActionController::RoutingError, 'Not Found'
    end

    def check_session
      puts '~' * 75
      puts session.loaded?
      puts '~' * 75
      redirect_to '/disable_add_blocker.html' unless session.loaded?
    end
  end
end
