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

require 'test_helper'

class NotificationTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
