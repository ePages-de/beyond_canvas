# frozen_string_literal: true

module BeyondCanvas
  module StatusCodes # :nodoc:
    extend ActiveSupport::Concern

    included do
      after_action :check_session_after # rubocop:disable Rails/LexicallyScopedActionFilter
      before_action :check_session_before
      around_action :check_session_around_action
    end

    private

    def bad_request
      raise ActionController::BadRequest, 'Bad Request'
    end

    def not_found
      raise ActionController::RoutingError, 'Not Found'
    end

    def check_session_around_action
      puts '<' * 75
      puts 'check_session_around_action'
      puts session.loaded?
      puts '<' * 75
    end

    def check_session_application
      puts 'x' * 75
      puts 'check_session_application'
      puts session.loaded?
      puts 'x' * 75
    end

    def check_session_before
      puts '\\' * 75
      puts 'check_session_before'
      puts session.loaded?
      puts '\\' * 75
      # redirect_to '/disable_add_blocker.html' unless session.loaded?
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
