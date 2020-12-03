class Permit < ActiveRecord::Base
    belongs_to :nationalpark
    belongs_to :tourist
end 