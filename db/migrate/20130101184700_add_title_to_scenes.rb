class AddTitleToScenes < ActiveRecord::Migration
  def change
    add_column "scenes", :title, :string
    add_column "scenes", :description, :text
  end
end
