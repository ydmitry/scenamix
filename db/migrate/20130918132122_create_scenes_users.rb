class CreateScenesUsers < ActiveRecord::Migration
  def change
    create_table :scenes_users, id: false do |t|
      t.integer :scene_id, references: [:scene, :id]
      t.integer :user_id, references: [:user, :id]
    end
  end
end
