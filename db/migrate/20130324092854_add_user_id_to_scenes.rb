class AddUserIdToScenes < ActiveRecord::Migration
  def change
    add_column :scenes, :user_id, :integer, :default => 0
    add_column :scenes, :ip_address, 'char(15)', :default => ''
  end
end
