class CreateAppReviews < ActiveRecord::Migration[6.1]
  def change
    create_table :app_reviews do |t|

      t.text :description
      t.integer :star_rating
      t.references :user, null: false, foreign_key: true
      t.references :restaurant, null: false, foreign_key: true

      t.timestamps
    end
  end
end
