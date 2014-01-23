# == Schema Information
#
# Table name: upvotes
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  answer_id  :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Upvote < ActiveRecord::Base
  attr_accessible :answer_id, :user_id

  belongs_to :user
  belongs_to :answer

  validates :answer_id, :uniqueness => {
  	:scope => :user_id
  }

  after_create :log_activity

  def log_activity
		Activity.create!({
			:subject_id   => self.user_id,   # This
     	:subject_type => "User",         # USER
			:action       => "Up voted",     # Up voted
			:target_id		=> self.answer_id, # This
      :target_type  => "Answer"        # ANSWER
		})
	end

end
