class AddToCaseReviews < ActiveRecord::Migration
  def change
    add_column :reviews, :case_id, :integer
  end
end
