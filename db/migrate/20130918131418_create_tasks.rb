class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.integer :scene_id
      t.integer :response_id
      t.integer :role_id

      t.timestamps
    end
  end
end
