require 'rest-client'

Nationalpark.destroy_all

np = RestClient.get 'https://developer.nps.gov/api/v1/parks?stateCode=&limit=497&api_key=amSoAnSXu48zw8sNc45tsop4Wriei2yPYPM8hrBJ'

np_array = JSON.parse(np)["data"]

np_array.each do |np|
    Nationalpark.create(
        name: np["fullName"],
        code: np["parkCode"],
        description: np["description"],
        location: np["latLong"],
        designation: np["designation"],
        weather: np["weatherInfo"]
    )
    end 
