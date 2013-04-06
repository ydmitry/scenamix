class AddLastResponseAtToScenes < ActiveRecord::Migration
  def change
    add_column :scenes, :last_response_at, :datetime
  end
end
