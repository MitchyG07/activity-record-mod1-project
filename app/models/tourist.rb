class Tourist < ActiveRecord::Base
    has_many :activities
    has_many :nationalparks, through: :activities
end 