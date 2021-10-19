module BeyondCanvas
  module Middleware
    class CockpitAppHeader
      def initialize(app)
        @app = app
      end

      def call(env)
        status, headers, response = @app.call(env)
        request = ActionDispatch::Request.new env

        headers['X-Frame-Options'] = 'ALLOWALL' # Some browsers like Firefox needs this to display the page correctly in the iframe

        puts request.headers['Sec-Fetch-Dest']

        # Referer
        # Sec-Fetch-Dest

        if request.headers['Sec-Fetch-Dest'] == 'iframe'
          puts '-' * 75
          puts request.referer
          puts request.headers['referer']
        puts '-' * 75
        end

        unless request.user_agent.match(/Chrome/)
          headers['Access-Control-Allow-Origin'] = '*'
          headers['Access-Control-Allow-Methods'] = 'POST, PUT, DELETE, GET, OPTIONS, PATCH, DELETE'
          headers['Access-Control-Request-Method'] = '*'
          headers['Access-Control-Allow-Headers'] = 'Origin, X-Requested-With, Content-Type, Accept, Authorization, X-Frame-Options, X-CSRF-Token'
        end

        [status, headers, response]
      end
    end
  end
end
