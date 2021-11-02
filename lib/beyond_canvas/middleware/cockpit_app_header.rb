module BeyondCanvas
  module Middleware
    class CockpitAppHeader
      def initialize(app)
        @app = app
      end

      def call(env)
        status, headers, response = @app.call(env)
        request = ActionDispatch::Request.new env
        sec_fetch_dest = request.headers['Sec-Fetch-Dest']

        if sec_fetch_dest == 'iframe' || (request.user_agent.match?(/Safari/) && sec_fetch_dest.blank?)
          headers['Content-Security-Policy'] = <<~POLICY.gsub "\n", ' '
            frame-ancestors #{request.session[:iframe_ancestor_url]} #{request.referer};
          POLICY
        end

        puts '_' * 80
        puts "Cockpit Sessions: #{request.session}"
        puts "Cockpit Sessions: #{request.session[:locale]}"
        puts "Cockpit Sessions: #{request.session[:custom_styles_url]}"
        puts "Cockpit Sessions: #{request.session[:iframe_ancestor_url]}"
        puts '_' * 80


        puts '-' * 75
        puts "CockpitAppHeader: #{request.path}"
        puts "CockpitAppHeader: #{request.headers['Sec-Fetch-Dest']}"
        puts "CockpitAppHeader: #{request.headers['Sec-Fetch-Site']}"
        puts "CockpitAppHeader: #{request.headers['Sec-Fetch-Mode']}"
        puts "CockpitAppHeader: #{request.headers['Sec-Fetch-User']}"
        puts "CockpitAppHeader: #{request.user_agent}"
        puts "CockpitAppHeader: #{request.headers['Accept']}"
        puts "CockpitAppHeader: #{request.headers['Accept-Encoding']}"
        puts "CockpitAppHeader: #{request.headers['Accept-Language']}"
        puts "CockpitAppHeader: #{request.headers['Cache-Control']}"
        puts "CockpitAppHeader: #{request.headers['Connection']}"
        puts "CockpitAppHeader: #{request.headers['Host']}"
        puts "CockpitAppHeader: #{request.headers['Origin']}"
        puts "CockpitAppHeader: #{request.headers['Referer']}"
        puts '-' * 75

        [status, headers, response]
      end
    end
  end
end
