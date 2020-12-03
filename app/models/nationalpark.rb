class Nationalpark < ActiveRecord::Base
    has_many :permits
    has_many :tourists, through: :permits 

    def find_by_state(state)
        array = []
        state = GetRequester.new("https://developer.nps.gov/api/v1/parks?stateCode=#{state}&api_key=amSoAnSXu48zw8sNc45tsop4Wriei2yPYPM8hrBJ")
        state_data = state.parse_json
        state_data['data'].each do |np|
            np.each do |p|
                array = p["fullName"]
            end
        end 
        puts array
    end 
       
end 