class PasswordResetsController < ApplicationController
  before_action :find_user_by_email, :valid_user, :check_expiration,
    only: [:edit, :update]

  def new
  end

  def edit
  end

  def create
    @user = User.find_by email: params[:password_reset][:email].downcase
    if @user
      @user.create_reset_digest
      @user.send_password_reset_email
      flash[:info] = t ".email_reset_sent_success"
      redirect_to root_url
    else
      flash.now[:danger] = t ".email_address_not_found"
      render :new
    end
  end

  def update
    if params[:user][:password].empty?
      @user.errors.add :password, t(".err_empty_msg")
      render :edit
    elsif @user.update_attributes user_params
      log_in @user
      @user.update_attributes reset_digest: nil
      flash[:success] = t ".password_has_been_reset."
      redirect_to @user
    else
      render :edit
    end
  end


  private

  def user_params
      params.require(:user).permit :password, :password_confirmation
    end

  def check_expiration
    if @user.password_reset_expired?
      flash[:danger] = t ".err_expired_msg"
      redirect_to new_password_reset_url
    end
  end

  def find_user_by_email
    unless @user = User.find_by(email: params[:email])
      flash[:danger] = t ".err_email_msg"
      redirect_to new_password_reset_url
    end
  end

  def valid_user
    unless @user && @user.activated? &&
      @user.authenticated?(:reset, params[:id])
      flash[:danger] = t ".err_invalid_msg"
      redirect_to root_url
    end
  end
end
