class UsersController < ApplicationController
  before_action :load_user, except: %i(index new create)
  before_action :logged_in_user, except: %i(new create show)
  before_action :correct_user, only: %i(edit update)
  before_action :admin_user, only: :destroy

  def index
    @users = User.page(params[:page]).per Settings.paginate
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params

    if @user.save
      @user.send_activation_email
      flash[:info] = t ".checkmail_please"
      redirect_to @user
    else
      render :new
    end
  end

  def show
    @microposts = @user.microposts.page(params[:page]).per Settings.post_page
  end

  def edit; end

  def update
    if @user.update_attributes user_params
      flash[:success] = t ".update_success"
      redirect_to @user
    else
      flash[:danger] = t ".update_fail"
      render :edit
    end
  end

  def destroy
    if @user.admin?
      flash[:danger] = t ".cant_delete_admin"
    elsif @user.destroy
      flash[:success] = t ".deleted"
    else
      flash[:danger] = t ".delete_failed"
    end
    redirect_to users_url
  end

  def following
    @title = t ".title"
    @users = @user.following.page(params[:page])
    render :show_follow
  end

  def followers
    @title = t ".title"
    @users = @user.followers.page(params[:page])
    render :show_follow
  end

  private

  def user_params
    params.require(:user).permit :name, :email, :password,
      :password_confirmation
  end

  def correct_user
    return if current_user? @user
    flash[:danger] = t ".incorrect_user"
    redirect_to root_url
  end

  def admin_user
    redirect_to root_url unless current_user.admin?
  end

  def load_user
    @user = User.find_by id: params[:id]

    return if @user
    flash[:danger] = t ".not_found"
    redirect_to root_path
  end
end
