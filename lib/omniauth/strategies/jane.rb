require "omniauth/strategies/oauth2"
require "json"
require "http"
require 'oauth2/response'

module OmniAuth
  module Strategies
    class Jane < OmniAuth::Strategies::OAuth2
      option :name, 'jane'
      option :provider_ignores_state, true
      option :site
      option :client_options, {
        token_url:     '/oauth/token',
        authorize_url: '/oauth'
      }

      def token_params
        params = super()
        params.merge(parse: :json)
      end

      def client_options
        @client_options ||= begin
          site = options.site 
          url_fixed_options = options.client_options.merge(
            authorize_url: "#{site.sub('api.', '')}#{options.client_options[:authorize_url]}",
            token_url: "#{site}/v1.0#{options.client_options[:token_url]}"
          )
          deep_symbolize(url_fixed_options)
        end
      end

      def client
        ::OAuth2::Jane::Client.new(options.client_id, options.client_secret, client_options)
      end
    end
  end
end
