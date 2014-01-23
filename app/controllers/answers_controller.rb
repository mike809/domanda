class AnswersController < ApplicationController

	def create
		params[:answer][:question_id] = params[:question_id]
		params[:answer][:author_id] = current_user.id
		answer = Answer.create(params[:answer])

		if answer.save 
			redirect_to :back
		else
			flash_now(answer.errors.full_messages)
			redirect_to :back
		end

	end

	def show
		@answer   = Answer.find(params[:id])
		@question = @answer.question

		render 'questions/show'
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
