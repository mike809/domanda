# == Schema Information
#
# Table name: topics
#
#  id                   :integer          not null, primary key
#  name                 :string(255)
#  description          :string(255)
#  picture_file_name    :string(255)
#  picture_content_type :string(255)
#  picture_file_size    :integer
#  picture_updated_at   :datetime
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#

class Topic < ActiveRecord::Base
  attr_accessible :name

  validates :name, :uniqueness => {
  	:case_sensitive => false
  }

end
