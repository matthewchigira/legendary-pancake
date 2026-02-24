class AddIndexesToTables < ActiveRecord::Migration[8.0]
  def change
    add_index :recipes, :difficulty
    add_index :recipes, :name
    add_index :reviews, :rating
  end
end
