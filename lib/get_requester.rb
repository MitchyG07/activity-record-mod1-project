require 'pry'
require 'net/http'
require 'open-uri'
require 'json'

class GetRequester

    URL = 'https://developer.nps.gov/api/v1/parks?api_key=amSoAnSXu48zw8sNc45tsop4Wriei2yPYPM8hrBJ'

    # api_key=amSoAnSXu48zw8sNc45tsop4Wriei2yPYPM8hrBJ

    def get_response_body
        uri = URI.parse(URL)
        response = Net::HTTP.get_response(uri)
        response.body 
    end

    def parse_json
        parks = JSON.parse(self.get_response_body)
        parks
    end

    def park_names 
    parks = JSON.parse(self.get_response_body)
    binding.pry
        # parks["data"].each do |each_park|
        #     each_park.map {|np| np["fullName"]}
        # end
    end 

end 