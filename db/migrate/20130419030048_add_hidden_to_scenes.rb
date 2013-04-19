class AddHiddenToScenes < ActiveRecord::Migration
  def change
    add_column :scenes, :hidden, :boolean, :default => false
  end
end
