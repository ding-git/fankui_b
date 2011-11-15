class AddTwoColumnToPresent < ActiveRecord::Migration
  def change
    add_column :presents, :replies_count, :integer,:null => false
    add_column :presents, :last_reply_user_id, :integer,:default => 0,:null => false
  end
end
