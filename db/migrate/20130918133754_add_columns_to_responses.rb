class AddColumnsToResponses < ActiveRecord::Migration
  def change
    add_column :responses, :role_id, :integer
    add_column :responses, :task_id, :integer
  end
end
