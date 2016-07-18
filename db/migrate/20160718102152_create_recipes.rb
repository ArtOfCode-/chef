class CreateRecipes < ActiveRecord::Migration[5.0]
  def change
    create_table :recipes do |t|
      t.string :title
      t.string :description
      t.string :method
      t.integer :time
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
