class CreateAppReviews < ActiveRecord::Migration[6.1]
  def change
    create_table :app_reviews do |t|

      t.string :comment
      t.integer :star_rating
      t.integer :user_id

      t.timestamps
    end
  end
end
