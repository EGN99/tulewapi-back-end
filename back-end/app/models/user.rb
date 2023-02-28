class User < ActiveRecord::Base
    has_many :reviews
    has_many :favorites
    has_many :restaurants, through: :reviews
    has_many :favorite_restaurants, through: :favorites, source: :restaurant
    
end