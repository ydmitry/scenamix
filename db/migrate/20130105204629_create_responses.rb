class CreateResponses < ActiveRecord::Migration
  def change
    create_table :responses do |t|
      t.integer :scene_id
      t.text :response
      t.timestamps
    end
    add_index :responses, :scene_id
  end
end
