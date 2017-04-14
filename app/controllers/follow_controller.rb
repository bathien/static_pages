class FollowController < ApplicationController
  before_action :load_user

  def following
    @title = t ".following"
    @users = @user.following.paginate page: params[:page],
      per_page: Settings.user.param_pages_following
    render "users/show_follow"
  end

  def followers
    @title = t ".followers"
    @users = @user.followers.paginate page: params[:page],
      per_page: Settings.user.param_pages_follower
    render "users/show_follow"
  end

  private

  def load_user
    unless @user = User.find_by(id: params[:id])
      flash[:danger] = t ".err_find_user"
      redirect_to request.referrer || root_url
    end
  end
end
