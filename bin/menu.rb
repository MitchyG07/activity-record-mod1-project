require 'pry'

class Menu
    def start
        puts 'Welcome to ActivityRecord!'
        puts 'We would love to help you find which National Parks you can do you favorite outdoor activities!'
        puts "Please enter your first name"
        @first_name = STDIN.gets.chomp
        puts "Please enter your last name"
        @last_name = STDIN.gets.chomp
        puts "Press 1 to explore activities to book with ActivityRecord!"
        puts "Press 2 to view and manage your past bookings"
        puts "Press 3 to exit"
        start_input = STDIN.gets.chomp
        self.viewer(start_input) 
    end 

    def viewer(start_input)
        if start_input == "1"
            self.booking_process
        elsif start_input == "2"
            self.activity_list
        else          
            self.exit
        end 
    end 

    def booking_process 
        puts "Here is a list of all available activities!"
        puts Activity.list_all_activities

        puts 'Enter the name of the activity you would like to do today!'
        @activity = STDIN.gets.chomp

        puts "Where would you like to go #{@activity}?"
        puts "Press 1 to search for a specific park"
        puts "Press 2 to search by state."
        puts "Press 3 to view a list of every park and its state with #{@activity}."
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
            self.view_all_by_activity
        when "4"
            self.exit
        end 
    end 

    def activity_list
        user = Tourist.find_by(first_name: @first_name, last_name: @last_name)
        if user              
            user_acts = Activity.find_all_activities(user.id)
            user_acts.each do |user|
                puts "#{user.id}. #{user.activity} at #{Nationalpark.find_by(id: user.nationalpark_id).name} on #{user.date}"
            end
                puts "Press 1 if you would like to delete any of your past bookings"
                puts "Press 2 if you would like to update any of your past bookings"
                user_input = STDIN.gets.chomp
                self.manage(user_input)
        else                
            puts "Oops! Looks like you haven't booked any activities with us!"
            self.start
        end 
    end 

    def manage(user_input)
        if user_input == "1" 
            puts "Enter the number associated with the booking you would like to delete"
            delete_input = STDIN.gets.chomp 
            Activity.find(delete_input).destroy
            puts "Your booking has been deleted"
            self.exit 
        elsif user_input == "2"
            puts "Enter the number associated with the booking you would like to update"
            id_input = STDIN.gets.chomp
            puts "Enter the new date you would like to do your activity (mm/dd/yyyy)"
            new_date = STDIN.gets.chomp
            Activity.find(id_input).update(date: new_date)
            puts "Your booking has been updated"
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
            self.search_by_state
        else 
            puts state_array
            puts "Which of these parks would you to visit for #{@activity}"
            @user_park = STDIN.gets.chomp
            self.get_park_info
        end 
    end 

    def view_all_by_activity
        puts "Here is a list of every park and its state with #{@activity}."
        puts Activity.view_all_parks_with_activity(@activity)
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
        puts "Please enter the date you would like to book your activity for: (mm/dd/yyyy)"
        date = STDIN.gets.chomp
        user = Tourist.find_or_create_a_tourist(@first_name, @last_name).id
        park_id = Nationalpark.find_by(name: @user_park).id 
        Activity.create(activity: @activity,nationalpark_id: park_id,tourist_id: user,date: date)
        puts "Thank you for booking your activity with ActivityRecord!"
    end 
        

    def exit
        puts 'goodbye!'
    end 
end 