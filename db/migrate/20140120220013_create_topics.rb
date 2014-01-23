class CreateTopics < ActiveRecord::Migration
  def change
    create_table :topics do |t|
      t.string     :name
      t.string     :description
      t.attachment :picture

      t.timestamps
    end
  end
end
