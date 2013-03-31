class AddUserIdToResponses < ActiveRecord::Migration
  def change
    add_column :responses, :user_id, :integer, :default => 0
    add_column :responses, :ip_address, 'char(15)', :default => ''
  end
end
