class Nationalpark < ActiveRecord::Base
    has_many :activities
    has_many :tourists, through: :activities
    
    def self.find_by_name(name)
        Nationalpark.find_by(name: name)
    end

    def self.find_by_state(state)
        state = GetRequester.new("https://developer.nps.gov/api/v1/parks?stateCode=#{state}&api_key=amSoAnSXu48zw8sNc45tsop4Wriei2yPYPM8hrBJ")
        state_data = state.parse_json
        state_data["data"].map{|np| np["fullName"]}
    end 

    def self.find_by_state_and_description(state)
        state_array = self.find_by_state(state)
        state_array.each_with_object({}) do |i, hash| 
            hash[i] = self.find_by(name: i).description
        end 
    end 

    def self.find_by_state_and_designation(state)
        state_array = self.find_by_state(state)
        state_array.each_with_object({}) do |i, hash| 
            hash[i] = self.find_by(name: i).designation
        end 
    end

    def campgrounds
        camp = GetRequester.new("https://developer.nps.gov/api/v1/campgrounds?parkCode=#{self.code}&limit=10000&api_key=amSoAnSXu48zw8sNc45tsop4Wriei2yPYPM8hrBJ")
        camp_data = camp.parse_json["data"]
    end

end 


        