class CreateActivities < ActiveRecord::Migration

  def change
    create_table :activities do |t|
    	t.string   :action
    	t.integer  :subject_id
    	t.string   :subject_type
    	t.integer  :target_id
    	t.string   :target_type

      t.timestamps
    end

  end
end
