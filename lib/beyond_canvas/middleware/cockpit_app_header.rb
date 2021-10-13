module BeyondCanvas
  module Middleware
    class CockpitAppHeader
      def initialize(app)
        @app = app
      end

      def call(env)
        status, headers, response = @app.call(env)
        request = ActionDispatch::Request.new env

        headers['Access-Control-Allow-Origin'] = '*'
        headers['Access-Control-Allow-Methods'] = 'POST, PUT, DELETE, GET, OPTIONS, PATCH, DELETE'
        headers['Access-Control-Request-Method'] = '*'
        headers['X-Frame-Options'] = 'ALLOWALL'

        [status, headers, response]
      end
    end
  end
end
