class CreateCases < ActiveRecord::Migration
  def change
    create_table :cases do |t|
      t.string :title
      t.text :description
      t.integer :level
      t.date :deadline
      t.string :product
      t.integer :user_id
      t.string :project

      t.timestamps
    end
  end
end
