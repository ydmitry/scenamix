class RemoveColumnsFromResponses < ActiveRecord::Migration
  def change
    remove_column :responses, :upvotes
    remove_column :responses, :downvotes
  end
end
