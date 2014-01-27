class ApplicationController < ActionController::Base
  protect_from_forgery

  include UsersHelper
  include SessionsHelper
  include ApplicationHelper
  
  before_filter :authenticate_user!
  before_filter :delete_notification

  private
  def delete_notification
    if params["note-id"]
      notification = Notification.find_by_id(params["note-id"])

      if notification
        notification.delete
      end
    end
  end

  def authenticate_user!
  	unless user_signed_in?
  		flash_msg(["You don't have permission to access this content. Please Sign in."])
  		redirect_to login_url
  	end
  end

end
