# frozen_string_literal: true

module BeyondCanvas
  module AddBlockerCheck # :nodoc:
    extend ActiveSupport::Concern

    included do
      before_action :check_session_availability
    end

    private

    def check_session_availability
      puts '*' * 75
      puts session.loaded?
      puts '*' * 75
      redirect_to '/disable_add_blocker.html' unless session.loaded?
    end
  end
end
