class AddIndexToParentId < ActiveRecord::Migration
  def change
  	add_index :responses, :parent_id
  end
end
