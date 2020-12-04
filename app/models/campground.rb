class Campground < ActiveRecord::Base
    belongs_to :nationalpark
    
    def self.find_by_park(park)
         camp = GetRequester.new("https://developer.nps.gov/api/v1/campgrounds?parkCode=#{park}&limit=10000&api_key=amSoAnSXu48zw8sNc45tsop4Wriei2yPYPM8hrBJ")
         camp_data = camp.parse_json["data"]
         camp_data.map{|camp| camp["name"]}
    end
end