class AddPeopleToUsers < ActiveRecord::Migration
  def change
    add_column :users, :people, :string
  end
end
