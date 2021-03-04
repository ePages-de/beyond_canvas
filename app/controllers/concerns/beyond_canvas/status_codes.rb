# frozen_string_literal: true

module BeyondCanvas
  module StatusCodes # :nodoc:
    extend ActiveSupport::Concern

    included do
      after_action :check_session_after # rubocop:disable Rails/LexicallyScopedActionFilter
    end

    private

    def bad_request
      raise ActionController::BadRequest, 'Bad Request'
    end

    def not_found
      raise ActionController::RoutingError, 'Not Found'
    end

    def check_session_application

    end

    def check_session_after
      puts '.' * 75
      puts 'check_session_after'
      puts session.loaded?
      puts '.' * 75
      # redirect_to '/disable_add_blocker.html' unless session.loaded?
    end

    def check_session
      puts '~' * 75
      puts 'check_session'
      puts session.loaded?
      puts '~' * 75
      # redirect_to '/disable_add_blocker.html' unless session.loaded?
    end

    def check_session_index
      puts '@' * 75
      puts 'check_session_index'
      puts session.loaded?
      puts '@' * 75
    end
  end
end
