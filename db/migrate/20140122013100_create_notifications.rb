class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
    	# t.integer  :source_id
    	t.integer  :owner_id
    	t.string   :owner_type
    	t.string	 :text
    	t.string   :url

      t.timestamps
    end
  end
end
