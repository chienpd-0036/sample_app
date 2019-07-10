class SessionsController < ApplicationController
  def new; end

  def create
    session = params[:session]
    user = User.find_by email: session[:email].downcase

    if user &. authenticate session[:password]
      login_check user
    else
      login_fail
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end

  private

  def login_check user
    if user.activated?
      log_in user
      session[:remember_me] == Settings.remember ? remember(user) : forget(user)
      flash[:success] = t ".admin" if current_user.admin?
      redirect_back_or user
    else
      activate_require
    end
  end

  def login_fail
    flash.now[:danger] = t ".invalid_pass"
    render :new
  end

  def activate_require
    flash[:warning] = t ".checkmail_please"
    redirect_to root_url
  end
end
