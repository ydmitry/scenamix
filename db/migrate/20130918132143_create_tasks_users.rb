class CreateTasksUsers < ActiveRecord::Migration
  def change
    create_table :tasks_users, id: false do |t|
      t.integer :user_id, references: [:user, :id]
      t.integer :task_id, references: [:task, :id]
    end
  end
end
