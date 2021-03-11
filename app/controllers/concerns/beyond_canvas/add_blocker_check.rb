# frozen_string_literal: true

module BeyondCanvas
  module AddBlockerCheck # :nodoc:
    extend ActiveSupport::Concern

    included do
      before_action :check_session_availability, unless: -> { controller_path == 'beyond_canvas/authentications' }
      # after_action :after_check_session_availability
    end

    private

    def check_session_availability
      puts '#' * 160
      puts 'before_check_session_availability'
      puts session.loaded?
      puts controller_name
      puts controller_path
      puts '#' * 160
      redirect_to '/disable_add_blocker.html' unless session.loaded?
    end

    def after_check_session_availability
      puts '~' * 100
      puts 'after_check_session_availability'
      puts session.loaded?
      puts controller_name
      puts '~' * 100
      # redirect_to '/disable_add_blocker.html' unless session.loaded?
    end
  end
end
