class CreateUsers < ActiveRecord::Migration
  def change
  	
    create_table :users do |t|
      t.string :username
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :password_digest
   		t.string :session_token
   		t.string :password_token 
   		# t.string :confirmation_token
   		# t.boolean :confirmed

      t.timestamps
    end

    add_index :users, :email, unique: true
    add_index :users, :username, unique: true
  end
end
