class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.integer :msgfrom_id
      t.integer :msg_to_id
      t.text :content
      t.boolean :deleted
      t.integer :related

      t.timestamps
    end
  end
end
