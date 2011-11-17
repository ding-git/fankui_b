class AddIpNoteFew < ActiveRecord::Migration
  def change
    add_column :solutions, :request_ip, :string
    add_column :reviews, :request_ip, :string
    add_column :cases, :request_ip, :string
    add_column :messages, :request_ip, :string
  end
end
