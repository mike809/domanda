# == Schema Information
#
# Table name: follows
#
#  id            :integer          not null, primary key
#  follower_id   :integer          not null
#  followee_id   :integer          not null
#  type_followee :string(255)
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class Follow < ActiveRecord::Base

	attr_accessible :followee_id, :follower_id, :type_followee

	belongs_to :follower, :class_name => "User"
	belongs_to :followee, :class_name => "User"

	validates :followee_id, :follower_id, :presence => true
	validates :follower_id, :uniqueness => { :scope => :followee_id }

	after_create :log_activity

  def log_activity
		Activity.create!({
			:subject_id 	=> self.follower_id,  				  # This
			:subject_type => "User",										  # User
			:action       => "Followed",								  # Followed
			:target_id		=> self.followee_id,					  # This 
			:target_type  => self.type_followee.camelize, # Thing 
		})

	end

end
