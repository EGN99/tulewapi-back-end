class Restaurant < ActiveRecord::Base
    has_many :reviews
    has_many :favorites
    has_many :reservations
    has_many :users, through: :reservations
    has_many :users, through: :reviews
    has_many :users_who_favorited, through: :favorites, source: :user

end