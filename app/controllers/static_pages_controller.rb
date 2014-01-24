class StaticPagesController < ApplicationController

	skip_before_filter :authenticate_user!
  
  def home
    if user_signed_in?
      @feed = current_user.feed.sort_by(&:updated_at).reverse.uniq
      render :feed
    else
      render :home
    end
  end

end
