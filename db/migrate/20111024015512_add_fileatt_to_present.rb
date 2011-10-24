class AddFileattToPresent < ActiveRecord::Migration
  def change
    add_column :presents, :fileatt, :string
  end
end
