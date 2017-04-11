class StaticPagesController < ApplicationController
  def help
  end

  def home
    if logged_in?
      @micropost = current_user.microposts.build
      @feed_items = current_user.feed.paginate page: params[:page],
        per_page: Settings.feed.param_pages_feeds
    end
  end

  def about
  end

  def contact
  end
end
