class CreateRecipes < ActiveRecord::Migration[8.0]
  def change
    create_table :recipes do |t|
      t.string :name
      t.text :description
      t.string :difficulty
      t.integer :prep_time_minutes
      t.integer :cook_time_minutes
      t.integer :servings
      t.string :image_url

      t.timestamps
    end
  end
end
