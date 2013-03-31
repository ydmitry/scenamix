class AddWeightToResponse < ActiveRecord::Migration
  def change
    add_column :responses, :weight, :integer, :default => 0
  end
end
