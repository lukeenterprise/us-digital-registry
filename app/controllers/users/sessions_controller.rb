class SessionsController < Devise::SessionsController
    def destroy
        current_user.invalidate_session!
        super
    end
    def logout
        reset_session
        render json:{ status:200, logged_out: true}
    end

end