module OmniAuth
    module LoginDotGov
      class LogoutUtility
        attr_reader :state
  
        Request = Struct.new(:redirect_uri, :state)
  
        # Initializes with one of idp_base_url, idp_configuration or end_session_endpoint.
        # Initializing with idp_base_url and idp_configuration may send an HTTP request to
        # fetch the OpenID configuration. The object should be memoized to avoid sending an
        # HTTP request for each logout.
        def initialize(idp_base_url: nil, idp_configuration: nil, end_session_endpoint: nil)
          check_initialize_arguments!(idp_base_url, idp_configuration, end_session_endpoint)
  
          if end_session_endpoint
            @end_session_endpoint = end_session_endpoint
          elsif idp_configuration
            @end_session_endpoint = idp_configuration.end_session_endpoint
          else
            configuration = OmniAuth::LoginDotGov::IdpConfiguration.new(idp_base_url: idp_base_url)
            # @end_session_endpoint = configuration.end_session_endpoint
          end
        end       

        def check_initialize_arguments!(idp_base_url, idp_configuration, end_session_endpoint)
        return if idp_base_url || end_session_endpoint || idp_configuration

        raise ArgumentError, 'idp_base_url, end_session_endpoint or idp_configuration must not be nil'
        end

      # @param id_token [String]
      # @param post_logout_redirect_uri [String]
      # @param state [String]
      # @return [Request]
        def build_request(id_token:, post_logout_redirect_uri:, state: nil)
        state ||= SecureRandom.urlsafe_base64(48)

        logout_params = { state: state, id_token_hint: id_token, post_logout_redirect_uri: post_logout_redirect_uri }

        Request.new(
          ENV['REGISTRY_IDP']+"openid_connect/logout?#{logout_params.to_query}",
          state
        )
       end
    end
  end
end 