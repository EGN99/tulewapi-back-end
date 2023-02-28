class RemoveStarRatingFromAppReviews < ActiveRecord::Migration[6.1]
  def change
    remove_column :app_reviews, :star_rating
  end
end
