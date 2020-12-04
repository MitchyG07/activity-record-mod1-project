class Menu
    def start
        puts 'Welcome to ActivityRecord!'
        puts 'We would love to help you find where you can do you favorite outdoor activities!'
        puts 'Wait one moment while generate a list of all available activities!'
        puts  Activity.list_all_activities

        puts 'Enter the name of the activity you would like to do today!'
        puts 'Press 1 to exit'
        @activity = STDIN.gets.chomp

        puts "Press 1 to search for park to do your activity at"
        puts "Press 2 to search by state"
        user_input = STDIN.gets.chomp
        self.input(user_input)
    end 

    def input(user_input)
        if user_input == "1"
            self.search_by_park
        elsif       
            user_input == "2"
            self.search_by_state
        end 
    end 

    def search_by_park
        puts 'What park would you like to go to?'
        user_park = STDIN.gets.chomp
        if Activity.find_if_park_has_your_activity(@activity, user_park) == true 
            puts "Yes, #{@activity} is available for booking at #{user_park}!"
            puts "Prior to booking, what else would you like to learn about #{user_park}?"
            # self.get_park_info(user_park)
        else            
            puts "We are sorry! #{@activity} is not available at #{user_park}."
            # self.input(user_input)
        end 
    end 

    def search_by_state
        response = RestClient.get("https://www.googleapis.com/books/v1/volumes?q=#{user_input}")
        json = JSON.parse(response.body)
        json["items"].each{|book| puts book["volumeInfo"]["title"]}
        puts "Hit any key to return to menu"
        user_input = STDIN.gets.chomp
        self.start
    end 

    def exit
        puts 'goodbye!'
    end 
end 