class Menu
    def start
        puts 'Welcome to ActivityRecord!'
        puts 'We would love to help you find where you can do you favorite outdoor activities!'
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
        @user_park = STDIN.gets.chomp
        if Activity.find_if_park_has_your_activity(@activity, @user_park) == true 
            puts "Yes, #{@activity} is available for booking at #{@user_park}!"
            puts "Prior to booking, what else would you like to learn about #{@user_park}?"
            # self.get_park_info(user_park)
            #next pathway
        else            
            puts "We are sorry! #{@activity} is not available at #{@user_park}."
            # self.input(user_input)
        end 
    end 

    def search_by_state
        puts 'Enter two character state code for your desired location'
        user_state = STDIN.gets.chomp
        state_array = Activity.find_parks_by_state_and_activity(@activity,user_state)
        if state_array.empty?
            puts "We are sorry, #{@activity} is not in #{user_state}!"
        else 
            puts state_array
            puts "Which of these parks would you to visit for #{@activity}"
            @user_park = STDIN.gets.chomp
            self.get_park_info(@user_park) 
        end 
    end 

    def get_park_info
        puts "1. Description"
        puts "2. Directions"
        puts "3. Designation (Type of federal park)"
        puts "4. Weather Information"
        puts "5. Campground Information" 
        puts "6. Book your activity now!" 
        puts "7. Exit"
        park_input = STDIN.gets.chomp 
        self.p_input(park_input)
    end 

    def p_input(park_input)
        park = Nationalpark.find_by_name(@user_park)
        case park_input
        when 1
            puts park.description
            self.get_park_info
        when 2
            puts park.location
            self.get_park_info
        when 3 
            puts park.designation 
            self.get_park_info
        when 4 
            puts park.weather 
            self.get_park_info
        when 5
            puts park.campgrounds
            self.get_park_info
        when 6
            puts park.designation 
            self.get_park_info
        when 7 
            self.exit 
        end 
    end 
        

    def exit
        puts 'goodbye!'
    end 
end 