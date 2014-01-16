class SessionsController < ApplicationController

	skip_before_filter :authenticate_user!, :except => [:destroy]

	def new
		render :new
	end

	def create
		@user = User.find_by_credentials(*params[:user].values)

		if @user
			login(@user)
			redirect_to user_url(@user) # Redirect to feed
		else
			flash_now(["Invalid credentaials."])
			render :new
		end
	end

	def destroy
		logout!
		redirect_to login_url
	end

end
