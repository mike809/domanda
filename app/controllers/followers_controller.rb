class FollowersController < ApplicationController
	
	def index
		user = User.find(params[:user_id])

		if user
			if params[:bool] == "true"
				@users = user.followers
				@title = "Followers"
			else
				@users = user.people_followed
				@title = "Following"
			end
			render :index
		else
			flash_msg(["User #{params[:id]} not found."])
			redirect_to :back
		end
	end

	def create
		follow               = Follow.new
		followee_id          = params[:id]
		follow.follower_id   = current_user.id
		follow.followee_id   = followee_id
		follow.type_followee = params[:type]

		if follow.save
			render :json => { 
				:alert => :info,
				:content =>  "You are now following #{User.find(followee_id).username}." 
			}
		else
			render :json => { :errors => follow.errors.full_messages }
		end
	end

	def destroy
		follow = Follow.find_by_follower_id_and_followee_id(current_user.id, params[:id])
		follow.delete if follow

		render :json => :ok
	end

end
