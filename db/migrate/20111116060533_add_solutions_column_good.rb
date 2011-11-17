class AddSolutionsColumnGood < ActiveRecord::Migration
  def change
    add_column :solutions, :good_number, :integer, :default => 0
  end
end
