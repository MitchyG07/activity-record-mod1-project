class Activity < ActiveRecord::Base
    belongs_to :tourist
    belongs_to :nationalpark
end 
