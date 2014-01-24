# == Schema Information
#
# Table name: questions
#
#  id         :integer          not null, primary key
#  title      :string(255)
#  body       :string(255)
#  author_id  :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Question < ActiveRecord::Base
  attr_accessible :author_id, :body, :title, :topic

  belongs_to :author, :class_name => "User"

  has_many :topic_questions
  has_many :topics, :through => :topic_questions, :source => :topic
	has_many :answers
	
	after_create :log_activity

	def log_activity
		Activity.create!({
			:subject_id		=> self.author_id,  # This
			:subject_type => "User",					# USER
			:action  			=> "Asked",					# Asked
			:target_id		=> self.id,					# This
			:target_type  => "Question"				# QUESTION
		})

		topics.each do |topic|
			Activity.create!({
				:subject_id   => self.id,					 # This
				:subject_type => "Question",			 # QUESTION
				:action  			=> "Question Added", # Was Added to
				:target_id		=> topic.id,				 # This
				:target_type  => "Topic"					 # TOPIC 
			})
		end
	end

	def name
		title
	end

	def followers
    User.find_by_sql(<<-SQL 
      SELECT 
        users.* 
      FROM 
        users
      JOIN 
        follows 
        ON 
        users.id = follows.follower_id 
      WHERE 
        follows.followee_id = #{self.id}
          AND 
        follows.type_followee = 'question'
      SQL
    )
  end

  def self.search(keywords)
    Question.where("lower(title) like ? OR lower(body) like ?", 
    								*(["%#{keywords.downcase}%"] * 2)) || []
  end
end
