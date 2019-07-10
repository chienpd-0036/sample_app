class StaticPagesController < ApplicationController
  def home
    return unless logged_in?
    @micropost = current_user.microposts.build
    @feed_items = current_user.feed.create_desc.page(params[:page])
      .per Settings.post_page
  end

  def help; end

  def about; end

  def contact; end
end
