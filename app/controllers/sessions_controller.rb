   # Assists in RP-initiated logout: https://developers.login.gov/oidc/#logout
      # @example RP-initiated logout in Rails controller
      module Users
        class SessionsController < Devise::SessionsController
          def destroy
            Rails.logger.info 'logging session'
            homepage='https://'+ENV['REGISTRY_HOSTNAME']
            Rails.logger.info homepage
            Rails.logger.info ENV['REGISTRY_HOMEPAGE']
            logout_request = self.class.logout_utility.build_request(id_token: session[:id_token],
              post_logout_redirect_uri:homepage
            )
            sign_out(current_user)
            redirect_to(logout_request.redirect_uri) and return
          end
      
          # Avoid making multiple HTTP requests to determine logout URL by memoizing utility class
          def self.logout_utility
            @logout_utility ||=
              OmniAuth::LoginDotGov::LogoutUtility.new(idp_base_url: ENV['REGISTRY_IDP'])
          end

        end
      end
      

