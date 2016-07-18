class AddAccessLevelToRecipes < ActiveRecord::Migration[5.0]
  def change
    add_reference :recipes, :access_level, foreign_key: true
  end
end
