class CreateAccessLevels < ActiveRecord::Migration[5.0]
  def change
    create_table :access_levels do |t|
      t.string :name
      t.string :description

      t.timestamps
    end
  end
end
