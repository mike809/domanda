# == Schema Information
#
# Table name: answers
#
#  id          :integer          not null, primary key
#  author_id   :integer
#  body        :string(255)
#  upvotes     :integer
#  question_id :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Answer < ActiveRecord::Base
  attr_accessible :author_id, :body, :upvotes, :question_id

  belongs_to :author, :class_name => "User"
  belongs_to :question

  has_many :upvotes

  after_create :log_activity

  def followers
    User.find_by_sql(<<-SQL 
      SELECT 
        * 
      FROM 
        users
      JOIN 
        follows 
        ON 
        users.id = follows.follower_id 
      WHERE 
        follows.followee_id = '1' 
          AND 
        follows.type_followee = 'Question'
      SQL
    )
  end

  def log_activity
		log = Activity.create!({
			:subject_id   => self.id,              # This
      :subject_type => "Answer",             # ANSWER
			:action       => "Answered",           # Answered
			:target_id    => self.question_id,     # This
      :target_type  => "Question"            # QUESTION
		})

    self.question.topics.each do |topic|
      log = Activity.create!({
        :subject_id   => topic.id,         # This
        :subject_type => "Topic",          # TOPIC
        :action       => "Answer Added",   # Answer Added
        :target_id    => self.id,          # This
        :target_type  => "Answer"          # ANSWER
      })
    end
	end

  def upvote(user)
	  Upvote.create!({
	  	:user_id => user.id,
	  	:answer_id => self.id
	  })
  end

  def downvote(user)
  	upvote = Upvote.find_by_user_id_and_answer_id(user.id, self.id)
  	upvote.delete if upvote
  end

  def name
    "#{body[0..15]}..."
  end

end
