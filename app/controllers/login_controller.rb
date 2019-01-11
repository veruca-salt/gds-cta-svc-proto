class LoginController < ApplicationController
  def new
  end
  def create
    if user = authenticate_with_google
      cookies.signed[:user_id] = user.id
      redirect_to user
    else
      redirect_to new_session_url, alert: 'authentication_failed'
    end
  end

  private
    def authenticate_with_google
      if flash[:google_sign_in_token].present?
        User.find_by google_id: GoogleSignIn::Identity.new(flash[:google_sign_in_token]).user_id
      end
    end
end
