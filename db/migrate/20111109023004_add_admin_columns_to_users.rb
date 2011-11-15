class AddAdminColumnsToUsers < ActiveRecord::Migration
  def change
        add_column :users, :admin, :string,:default => false
  end
end
