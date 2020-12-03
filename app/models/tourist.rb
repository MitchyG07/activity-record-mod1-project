class Tourist < ActiveRecord::Base
    has_many :permits
    has_many :nationalparks, through: :permits
end 