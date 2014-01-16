class StaticPagesController < ApplicationController

	skip_before_filter :authenticate_user!
  
  def home
    if user_signed_in?
        user_url(current_user) # Feed
    else
      render :home
    end
  end

end
