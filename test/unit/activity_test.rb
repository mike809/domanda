# == Schema Information
#
# Table name: activities
#
#  id           :integer          not null, primary key
#  action       :string(255)
#  subject_id   :integer
#  subject_type :string(255)
#  target_id    :integer
#  target_type  :string(255)
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

require 'test_helper'

class ActivityTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
