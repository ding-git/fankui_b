class CreatePresents < ActiveRecord::Migration
  def change
    create_table :presents do |t|
      t.integer :user_id
      t.integer :level
      t.date :request_time
      t.text :description
      t.text :cause
      t.text :solution
      t.text :note
      t.integer :question_type
      t.boolean :resolve, :default => false

      t.timestamps
    end
  end
end
