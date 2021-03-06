class UsersController < ApplicationController

	skip_before_filter :authenticate_user!, :only => [:new, :create]

	def new
		render :new
	end

	def create
		@user = User.new(params[:user])

		if @user.valid?
			login(@user)
			flash_msg(["You successfully created an account!"], :success)
			redirect_to user_url(@user)
		else
			flash_now(@user.errors.full_messages)
			render :new
		end
	end

	def show
		@user = User.find_by_username(params[:id])

		if @user.nil?
      flash_msg(["User #{params[:id]} does not exist."])
      redirect_to :back
    else
      render :show
    end  
	end

	def edit
		@user = current_user
		render :edit
	end

	def update
		debugger
	end
	
end