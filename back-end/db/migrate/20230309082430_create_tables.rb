class CreateTables < ActiveRecord::Migration[6.1]
  def change
      create_table :tables do |t|
      t.string :name
      t.integer :capacity
      t.integer :restaurant_id
      t.string :description
      
      t.timestamps
    end
  end
end