# app/controllers/users/omniauth_controller.rb
module Users
  class OmniauthCallbacksController < ApplicationController
    def login_dot_gov
      Rails.logger.info 'logging amniauth info'
      omniauth_info = request.env['omniauth.auth']['info']
      Rails.logger.info request.env['omniauth.auth']['credentials']
      omniauth_credentials = request.env['omniauth.auth']['credentials']
      session[:id_token] = omniauth_credentials['id_token']
      @user = User.find_by(email: omniauth_info['email'])
      if @user
        if(@user.isactive)
          Rails.logger.info 'user is active'
          @user.update!(user: omniauth_info['uuid'])
          sign_in @user
          redirect_to admin_path
        else
          Rails.logger.info 'user is inactive'
          redirect_to root_path, status: 302, notice: "Your account is locked.  Please contact the administrators."
        end
      
      # Can't find an account, tell user to contact login.gov team
      else
        if(omniauth_info['email'].end_with?(".gov") || omniauth_info['email'].end_with?(".mil"))
          new_user = User.create({
            email: omniauth_info['email'],
            user: omniauth_info['email'],
            first_name: omniauth_info['given_name'],
            last_name: omniauth_info['family_name']
          })
          redirect_to admin_user_path(new_user.id), notice: "You do not currently have an agency assigned to your account, please update your user profile to manage accounts"
        else
          redirect_to root_path, status: 302, notice: "Your account could not be found.  Please contact the administrators."
        end
      end
    end


    def failure
      redirect_to root_path, status: 302, notice: "Your account could not be found.  Please contact the administrators."
    end
  end
end
