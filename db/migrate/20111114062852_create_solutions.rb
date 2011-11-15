class CreateSolutions < ActiveRecord::Migration
  def change
    create_table :solutions do |t|
      t.integer :case_id
      t.integer :user_id
      t.integer :version_number
      t.integer :max_number
      t.text :reason
      t.text :content

      t.timestamps
    end
  end
end
