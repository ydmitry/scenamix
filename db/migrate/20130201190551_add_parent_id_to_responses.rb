class AddParentIdToResponses < ActiveRecord::Migration
  def change
    add_column :responses, :parent_id, :integer, :default => 0
  end
end
