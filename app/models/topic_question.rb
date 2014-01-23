# == Schema Information
#
# Table name: topic_questions
#
#  id          :integer          not null, primary key
#  question_id :integer
#  topic_id    :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class TopicQuestion < ActiveRecord::Base

	attr_accessible :question_id, :topic_id

	belongs_to :question
	belongs_to :topic

end
