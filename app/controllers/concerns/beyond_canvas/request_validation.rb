module BeyondCanvas
  module RequestValidation
    extend ActiveSupport::Concern

    private

    def validate_app_installation_request!
      bad_request unless app_installation_params? && valid_signature?(params[:signature],
                                                                      app_installation_data,
                                                                      BeyondApi.configuration.client_secret)
    end

    def app_installation_params?
      if params[:code].nil? ||
        params[:signature].nil? ||
        params[:return_url].nil? ||
        params[:api_url].nil? ||
        params[:access_token_url].nil?
        false
      else
        true
      end
    end

    def app_installation_data
      "#{params[:code]}:#{params[:access_token_url]}"
    end

    def valid_signature?(signature, data, secret)
      return true unless Rails.env.production?

      digest = OpenSSL::Digest.new('SHA1')
      hmac = OpenSSL::HMAC.digest(digest, secret, data)
      signature == Base64.encode64(hmac).chop
    end
  end
end
