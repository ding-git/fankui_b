class AddCausedetailColumnToPresent < ActiveRecord::Migration
  def change
    add_column :presents, :cause_detail, :string
  end
end
