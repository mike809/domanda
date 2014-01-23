class CreateFollows < ActiveRecord::Migration
  
  def change
  	create_table :follows do |t|
  		t.integer  :follower_id, :null => false
  		t.integer  :followee_id, :null => false
  		t.string   :type_followee

  		t.timestamps
  	end
    
  	add_index :follows, [:followee_id, :follower_id, :type_followee], :unique => true
  end

end
