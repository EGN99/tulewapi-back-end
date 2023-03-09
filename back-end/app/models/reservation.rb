class Reservation < ActiveRecord::Base
    belongs_to :User
    belongs_to :Table
    belongs_to :Restaurant
end