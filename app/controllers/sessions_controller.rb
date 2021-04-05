   # Assists in RP-initiated logout: https://developers.login.gov/oidc/#logout
      # @example RP-initiated logout in Rails controller
        class SessionsController < Devise::SessionsController
          def destroy
            logout_request = self.class.logout_utility.build_request(id_token: session[:id_token],
              post_logout_redirect_uri: 'http://localhost:3001/'
            )
            sign_out(current_user)
            redirect_to(logout_request.redirect_uri) and return
          end
      
          # Avoid making multiple HTTP requests to determine logout URL by memoizing utility class
          def self.logout_utility
            @logout_utility ||=
              OmniAuth::LoginDotGov::LogoutUtility.new(idp_base_url: Rails.configuration.oidc['idp_url'])
          end
        end