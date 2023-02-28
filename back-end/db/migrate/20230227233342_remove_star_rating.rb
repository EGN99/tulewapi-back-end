class RemoveStarRating < ActiveRecord::Migration[6.1]
  def change
    remove_column :reviews, :star_rating
  end
end
