class QuestionsController < ApplicationController
  
  def index
    user = User.find_by_username(params[:user_id])
    @questions = Question.where(:author_id => user.id)

    if @questions.empty?
      flash_msg(["This user haven't asked any questions."], :info)
      redirect_to user_url(user)
    else
      render :index
    end
  end

	def edit
		@edit = true
		@question = Question.find(params[:id])
		render :edit
	end

  def show
  	@question = Question.find(params[:id])

  	if @question
  		render :show
  	else
  		flash_msg(["Question does not exist"], :warning)
  		redirect_to :back
  	end
  end

  def update
  	topic_name = params[:question].delete(:topic)
  	topic = Topic.find_by_name(topic_name)
		
		unless topic
	  	topic = Topic.create!(:name => topic_name)
  	end
  	
  	question = Question.find(params[:id])
  	
		TopicQuestion.create!(
  		:topic_id    => topic.id,
  		:question_id => question.id)

  	if question.update_attributes(params[:question])
  		flash_msg(["Question successfully updated!"], :success)
  	else
  		flash_msg(question.errors.full_messages)
  	end

  	redirect_to user_question_url(current_user, question)
  end

  def destroy
  	question = Question.find(params[:id])

  	if question.delete
  		flash_msg(["Question successfully deleted."], :warning)
  	else
  		flash_msg(["Question could not be deleted deleted."])
  	end
  end

  def create	
  	topic_name = params[:question].delete(:topic)
  	topic = Topic.find_by_name(topic_name)

  	question = Question.new(params[:question])
  	question.author_id = current_user.id

  	unless topic
  		topic = Topic.create!(:name => topic_name)
  	end

  	TopicQuestion.create!(
  		:topic_id    => topic.id,
  		:question_id => question.id)

  	if question.save
  		flash_msg(["Question created!"], :info)
  		redirect_to user_question_url(current_user, question)
  	else
  		flash_msg(question.errors.full_messages)
  		redirect_to user_url(current_user)
  	end

  end

end
