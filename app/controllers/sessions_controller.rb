class SessionsController < ApplicationController

  def create
    auth = request.env["omniauth.auth"]
    @user = User.find_by_provider_and_uid(auth[:provider], auth[:uid])

    if !@user
      @user = User.create_with_omniauth(auth)
    end

    session[:user_id] = @user.id
    redirect_to '/'
  end

  def destroy
    session[:user_id] = nil
    redirect_to '/'
  end

end
