class SessionsController < ApplicationController
  def show
    flash.now.alert = params[:message] if params[:message]
  end

  def create
    reset_session
    user = User.from_omniauth(request.env['omniauth.auth'])
    session[:user_id] = user.id
    redirect_to root_url, notice: 'Logged in successfully'
  end

  def destroy
    reset_session
    redirect_to login_url, notice: 'Logged out successfully'
  end
end
