class Nationalpark < ActiveRecord::Base
    has_many :permits
    has_many :tourists, through: :permits 

    PARKSURL = "https://developer.nps.gov/api/v1/parks?api_key=amSoAnSXu48zw8sNc45tsop4Wriei2yPYPM8hrBJ"

    def self.find_by_state(state)
        state = GetRequester.new("https://developer.nps.gov/api/v1/parks?stateCode=#{state}&api_key=amSoAnSXu48zw8sNc45tsop4Wriei2yPYPM8hrBJ")
        state_data = state.parse_json
        state_data["data"].map{|np| np["fullName"]}
    end 

    # def self.find_by_name(name)
    #     park = GetRequester.new(PARKSURL)
    #     data = park.parse_json
    #     data["data"].select{|np| np["fullName"] == name}
    # end

    # def select_park
    #     park = GetRequester.new(PARKSURL)
    #     data = park.parse_json
    #     data["data"].select{|np| np["fullName"] == self.name}
    # end

    # def park_state
    #     park = self.select_park
    #     park.map{|np| np["states"]}
    # end

end 
