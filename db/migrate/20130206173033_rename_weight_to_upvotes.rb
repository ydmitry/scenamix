class RenameWeightToUpvotes < ActiveRecord::Migration
  def up
    rename_column :responses, :weight, :upvotes
    add_column :responses, :downvotes, :int, :default => 0
  end

  def down
    rename_column :responses, :upvotes, :weight
    remove_column :responses, :downvotes
  end
end
