class CreateAnswers < ActiveRecord::Migration
  def change
    create_table :answers do |t|
      t.integer :author_id
      t.string  :body
      t.integer :upvotes
      t.integer :question_id

      t.timestamps
    end
  end
end
