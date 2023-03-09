class CreateReservations < ActiveRecord::Migration[6.1]
    def change
      create_table :reservations do |t|
        t.integer :restaurant_id
        t.integer :user_id
        t.integer :num_clients
        t.integer :table_id
        t.time :time
        t.date :date
        t.string :comment

        t.timestamps
    end
  end
end
