class Tourist < ActiveRecord::Base
    has_many :activities
    has_many :nationalparks, through: :activities

    def full_name 
        "#{self.first_name} #{self.last_name}"
    end 

    def self.find_or_create_a_tourist(first_name, last_name)
        self.find_or_create_by(first_name: first_name, last_name: last_name)
    end 

end 