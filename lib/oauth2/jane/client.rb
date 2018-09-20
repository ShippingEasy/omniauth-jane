# Modify OAuth2 Client to use json instead of form encoded post for token
require 'json'

module OAuth2
  module Jane
    class Client < ::OAuth2::Client
        def get_token(params, access_token_opts = {}, access_token_class = AccessToken) # rubocop:disable Metrics/AbcSize, Metrics/MethodLength
        params = Authenticator.new(id, secret, options[:auth_scheme]).apply(params)
        opts = {:raise_errors => options[:raise_errors], :parse => params.delete(:parse)}
        headers = params.delete(:headers) || {}
        if options[:token_method] == :post
          # --------------- Change from original implementation ---------------
          opts[:body] = JSON.generate params
          opts[:headers] = {'Content-Type' => 'application/json'}
          # --------------------------- Change end ----------------------------
        else
          opts[:params] = params
          opts[:headers] = {}
        end
        opts[:headers].merge!(headers)
        response = request(options[:token_method], token_url, opts)
        if options[:raise_errors] && !(response.parsed.is_a?(Hash) && response.parsed['access_token'])
          error = Error.new(response)
          raise(error)
        end
        access_token_class.from_hash(self, response.parsed.merge(access_token_opts))
      end
    end
  end
end