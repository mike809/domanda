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

require 'test_helper'

class AnswerTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
