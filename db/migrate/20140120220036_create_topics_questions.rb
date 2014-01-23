class CreateTopicsQuestions < ActiveRecord::Migration
  
  def change
  	create_table :topic_questions do |t|
  		t.integer :question_id
  		t.integer :topic_id

  		t.timestamps
  	end
  end

end
