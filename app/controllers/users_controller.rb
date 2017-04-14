class UsersController < ApplicationController
  before_action :logged_in_user, except: [:new, :create]
  before_action :load_user, except: [:index, :new, :create]
  before_action :correct_user, only: [:edit, :update]
  before_action :verify_admin, only: :destroy
  before_action :load_micropost, only: :show

  def index
    @users = User.select(:id, :name, :email).paginate page: params[:page],
      per_page: Settings.user.param_pages_users
  end

  def show
  end

  def new
    @user = User.new
  end

  def edit
  end

  def create
    @user = User.new user_params
    if @user.save
      if Rails.env.development?
        @user.send_activation_email
        flash[:info] = t ".check_email_activation"
        redirect_to root_url
      else
        @user.activate
        log_in @user
        flash[:success] = t ".account_activated"
        redirect_to @user
      end
    else
      render :new
    end
  end

  def update
    if @user.update_attributes user_params
      flash[:success] = t ".profile_updated"
      redirect_to @user
    else
      render :edit
    end
  end

  def destroy
    @user.destroy
    flash[:success] =  t ".user_deleted"
    redirect_to users_url
  end

  private

  def user_params
    params.require(:user).permit :name, :email, :password, :password_confirmation
  end

  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = t ".please_log_in"
      redirect_to login_url
    end
  end

  def correct_user
    redirect_to root_url unless current_user? @user
  end

  def verify_admin
    redirect_to root_url unless current_user.admin?
  end

  def load_user
    unless @user = User.find_by(id: params[:id])
      flash[:danger] = t ".err_find_user"
      redirect_to request.referrer || root_url
    end
  end

  def load_micropost
    @microposts = @user.microposts.paginate page: params[:page],
      per_page: Settings.micropost.param_pages_microposts
  end
end
