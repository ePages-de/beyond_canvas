# frozen_string_literal: true

module BeyondCanvas
  module AddBlockerCheck # :nodoc:
    extend ActiveSupport::Concern

    included do
      before_action :check_session_availability, unless: -> { controller_path == 'beyond_canvas/authentications' }
    end

    private

    def check_session_availability
      redirect_to '/disable_add_blocker.html' unless session.loaded?
    end
  end
end
