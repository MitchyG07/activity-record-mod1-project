class Nationalpark < ActiveRecord::Base
    has_many :permits
    has_many :tourists, through: :permits 

    def find_by_state(state)
        array = []
        counter = 0
        state = GetRequester.new("https://developer.nps.gov/api/v1/parks?stateCode=#{state}&api_key=amSoAnSXu48zw8sNc45tsop4Wriei2yPYPM8hrBJ")
        state_data = state.parse_json
        while counter < state_data["data"].length
            array << state_data["data"][counter]["fullName"]
            counter += 1 
        end 
        puts array
    end 
end 
       