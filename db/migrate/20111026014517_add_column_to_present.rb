class AddColumnToPresent < ActiveRecord::Migration
  def change
    add_column :presents, :title, :string
  end
end
