class NationalPark < ActiveRecord::Base
    has_many :permits
    has_many :tourists, through: :permits 
end 