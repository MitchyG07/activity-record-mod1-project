require 'pry'

class Menu
    def start
        puts 'Welcome to ActivityRecord!'
        puts 'We would love to help you find where you can do you favorite outdoor activities!'
        puts "Please enter your first name"
        @first_name = STDIN.gets.chomp
        puts "Please enter your last name"
        @last_name = STDIN.gets.chomp
        puts "Here is a list of all available activities!"
        puts Activity.list_all_activities

        puts 'Enter the name of the activity you would like to do today!'
        @activity = STDIN.gets.chomp

        puts "Press 1 to search for park to do your activity at"
        puts "Press 2 to search by state"
        puts "Press 3 to view or delete your past bookings"
        puts "Press 4 to exit"
        user_input = STDIN.gets.chomp
        self.input(user_input)
    end 

    def input(user_input)
        system "clear"
        case user_input
        when "1"
            self.search_by_park
        when "2"
            self.search_by_state
        when "3"
            self.activity_list 
        when "4"
            self.exit
        end 
    end 

    def activity_list
        user = Tourist.find_by(first_name: @first_name, last_name: @last_name).id
        if user              
            user_acts = Activity.find_all_activities(user)
            user_acts.each do |user|
                puts "#{user.id}. #{user.activity} at #{Nationalpark.find_by(id: user.nationalpark_id).name}"
            end
                puts "Press 1 if you would like to delete any of your past bookings"
                user_input = STDIN.gets.chomp
                self.delete(user_input)
        else                
            puts "Oops! Looks like you haven't booked any activities with us!"
            self.start
        end 
    end 

    def delete(user_input)
        if user_input == "1" 
            puts "Enter the number associated with the booking you would like to delete"
            delete_input = STDIN.gets.chomp 
            Activity.find(delete_input).destroy
            puts "Your booking has been deleted"
            self.exit 
        else
            self.start
        end
    end

    def search_by_park
        puts 'What park would you like to go to?'
        @user_park = STDIN.gets.chomp
        if Activity.find_if_park_has_your_activity(@activity, @user_park) == true 
            puts "Yes, #{@activity} is available for booking at #{@user_park}!"
            puts "Prior to booking, what else would you like to learn about #{@user_park}?"
            self.get_park_info
            # self.get_park_info(user_park)
            #next pathway
        else            
            puts "We are sorry! #{@activity} is not available at #{@user_park}."
            self.start
            # self.input(user_input)
        end 
    end 

    def search_by_state
        puts 'Enter two character state code for your desired location'
        user_state = STDIN.gets.chomp
        state_array = Activity.find_parks_by_state_and_activity(@activity,user_state)
        if state_array.empty?
            puts "We are sorry, #{@activity} is not in #{user_state}!"
            self.start
        else 
            puts state_array
            puts "Which of these parks would you to visit for #{@activity}"
            @user_park = STDIN.gets.chomp
            self.get_park_info
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
        when "1"
            puts park.description
            self.get_park_info
        when "2"
            puts park.location
            self.get_park_info
        when "3" 
            puts park.designation 
            self.get_park_info
        when "4" 
            puts park.weather 
            self.get_park_info
        when "5"
            puts park.campgrounds
            self.get_park_info
        when "6"
            self.book_now
        when "7" 
            self.exit 
        end 
    end 

    def book_now
        user = Tourist.find_or_create_a_tourist(@first_name, @last_name).id
        park_id = Nationalpark.find_by(name: @user_park).id 
        Activity.create(activity: @activity,nationalpark_id: park_id,tourist_id: user)
        puts "Thank you for booking your activity with ActivityRecord!"
    end 
        

    def exit
        puts 'goodbye!'
    end 
end 