# == Schema Information
#
# Table name: notifications
#
#  id         :integer          not null, primary key
#  owner_id   :integer
#  owner_type :string(255)
#  text       :string(255)
#  url        :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Notification < ActiveRecord::Base
  attr_accessible :owner_id, :owner_type, :url, :text

  after_create :modify_url

  def modify_url
  	self.url += "?note-id=#{self.id}"
  	self.save
  end
	
	def owner
		owner_type.constantize.find(owner_id)
	end

end
