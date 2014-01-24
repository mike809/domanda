class AnswersController < ApplicationController

	def create
		params[:answer][:question_id] = params[:question_id]
		params[:answer][:author_id]   = current_user.id
		answer = Answer.create(params[:answer])

		if answer.save 
			redirect_to :back
		else
			flash_now(answer.errors.full_messages)
			redirect_to :back
		end

	end

	def show
		@answer   = Answer.find_by_id(params[:id])
		if @answer
			@question = @answer.question
			render 'questions/show'
		else
			flash_msg(["Answer not found."])
			redirect_to :back
		end
	end

	def index
		user       = User.find_by_username(params[:user_id])
		@answers   = Answer.where(:author_id => user.id)

		if @answers
			render :index
		else
			flash_msg(["This user hasn't answered any questions yet."])
			redirect_to user_url(user)
		end
	end

	def update

	end

	def destroy

	end

	def upvote
		answer = Answer.find(params[:id])
		answer.upvote(current_user)
		render :json => { id: answer.id, votes: answer.upvotes.count }
	end

	def downvote
		answer = Answer.find(params[:id])
		answer.downvote
		render :json => { id: answer.id, votes: answer.upvotes.count }
	end
end
