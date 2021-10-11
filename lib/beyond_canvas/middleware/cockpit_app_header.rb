module BeyondCanvas
  module Middleware
    class CockpitAppHeader
      def initialize(app)
        @app = app
      end

      def call(env)
        status, headers, response = @app.call(env)
        request = ActionDispatch::Request.new env
        headers['X-Frame-Options'] = 'ALLOWALL'

        [status, headers, response]
      end
    end
  end
end
