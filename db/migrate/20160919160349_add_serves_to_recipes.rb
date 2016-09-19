class AddServesToRecipes < ActiveRecord::Migration[5.0]
  def change
    add_column :recipes, :serves, :integer
  end
end
