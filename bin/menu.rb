class Menu
    def welcome
        puts '-----------------------------'
        puts '| Welcome to ActivityRecord!|'.cyan
        puts '-----------------------------'
        puts "Let's find a location for you to do your favorite outdoor activity!"
        puts "-------------------------------------------------------------------".cyan
        puts "Please enter your username"
        @username = STDIN.gets.chomp
        if Tourist.find_by(username: @username)
            system "clear"
            self.start
        else
            puts "Please enter your first name"
            puts "----------------------------".cyan
            @first_name = STDIN.gets.chomp
            puts "Please enter your last name"
            puts "----------------------------".cyan
            @last_name = STDIN.gets.chomp
            Tourist.create(first_name: @first_name, last_name: @last_name, username: @username)
            system "clear"
            self.start
        end
    end

    def start
        puts "Main Menu"
        puts "----------".cyan
        puts "Press 1".cyan + " to explore activities to book with ActivityRecord!"
        puts "Press 2".cyan + " to view and manage your past bookings"
        puts "Press 3".cyan + " to exit"
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
        system "clear"
        puts "Here is a list of all available activities!"
        puts "-------------------------------------------".cyan
        puts Activity.list_all_activities
        puts "----------------------------------------------------------".cyan
        puts 'Enter the name of the activity you would like to do today!'
        @activity = STDIN.gets.chomp
        until Activity.list_all_activities.include? @activity
            puts "Sorry #{@activity} is not a listed activity. Please re-enter."
            @activity = STDIN.gets.chomp
        end

        system "clear"
        puts "Where would you like to go #{@activity}?"
        puts "-----------------------------------------".cyan
        puts "Press 1".cyan + " to search for a specific park"
        puts "Press 2".cyan + " to search by state"
        puts "Press 3".cyan  + " to view a list of every park and its state with #{@activity}"
        puts "Press 4".cyan + " to return to the main menu"
        puts "Press 5".cyan + " to exit"
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
            self.start
        when "5"
            self.exit
        end 
    end 

    def activity_list
        system "clear"
        @user = Tourist.find_by(username: @username)              
        @user_acts = Activity.find_all_activities(@user.id)
        unless @user_acts.empty?
                @user_acts.each do |user|
                puts "##{user.id}. #{user.activity} at #{Nationalpark.find_by(id: user.nationalpark_id).name} on #{user.date}".cyan
                end
                puts "Press 1".red + " if you would like to delete any of your past bookings"
                puts "Press 2".red + " if you would like to update any of your past bookings"
                puts "Press any key to return to the main menu"
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
            puts "Your booking has been deleted. Returning to main menu."
            self.start
        elsif user_input == "2"
            puts "Enter the number associated with the booking you would like to update"
            id_input = STDIN.gets.chomp
            valid_id = @user_acts.map {|user| user.id.to_s}
                until valid_id.include? id_input
                puts "Sorry #{id_input} is not a valid input."
                id_input = STDIN.gets.chomp
                end 
            puts "Enter the new date you would like to do your activity (mm/dd/yyyy)"
            new_date = STDIN.gets.chomp
            Activity.find(id_input).update(date: new_date)
            puts "Your booking has been updated. Returning to main menu."
            self.start
        else
            self.start
        end
    end

    def search_by_park
        puts 'What park would you like to go to?'
        puts "-----------------------------------".cyan
        @user_park = STDIN.gets.chomp
  
        if Activity.find_if_park_has_your_activity(@activity, @user_park) == true 
            puts "Yes, #{@activity} is available for booking at #{@user_park}!".green
            puts "-------------------------------------------------------------".cyan
            puts "Prior to booking, what else would you like to learn about #{@user_park}?"
            self.get_park_info
        else            
            puts "We are sorry! #{@activity} is not available at #{@user_park}.".red
            self.start
        end 
    end 

    def search_by_state
        puts 'Enter two character state code for your desired location'
        puts '--------------------------------------------------------'.cyan
        user_state = STDIN.gets.chomp
        state_array = Activity.find_parks_by_state_and_activity(@activity,user_state)
        if state_array.empty?
            puts "We are sorry, #{@activity} is not in #{user_state}!"
            self.start
        else 
            puts state_array
            puts "--------------------------------------------------------".cyan
            puts "Which of these parks would you to visit for #{@activity}"
            @user_park = STDIN.gets.chomp
            until Nationalpark.exists?(name: @user_park)
                puts "Sorry #{@user_park} is not a valid park for #{@activity}. Please re-enter."
                @user_park = STDIN.gets.chomp
            end           
            self.get_park_info
        end 
    end 

    def view_all_by_activity
        puts "Here is a list of every park and its state with #{@activity}."
        puts Activity.view_all_parks_with_activity(@activity)
        puts "Which of these parks would you to visit for #{@activity}"
        @user_park = STDIN.gets.chomp
        until Nationalpark.exists?(name: @user_park)
            puts "Sorry #{@user_park} is not a valid park for #{@activity}. Please re-enter."
            @user_park = STDIN.gets.chomp
        end 
        self.get_park_info
    end

    def get_park_info
        puts "----------------".cyan
        puts "1. Description"
        puts "2. Directions"
        puts "3. Designation (Type of federal park)"
        puts "4. Weather Information"
        puts "5. Campground Information" 
        puts "6. Book your activity now!" 
        puts "7. Main Menu"
        park_input = STDIN.gets.chomp 
        self.p_input(park_input)
    end 

    def p_input(park_input)
        system "clear"
        park = Nationalpark.find_by_name(@user_park)
        case park_input
        when "1"
            puts park.description.cyan
            self.get_park_info
        when "2"
            puts park.location.cyan
            self.get_park_info
        when "3" 
            puts park.designation.cyan
            self.get_park_info
        when "4" 
            puts park.weather.cyan
            self.get_park_info
        when "5"
            puts park.campgrounds
            self.get_park_info
        when "6"
            self.book_now
        when "7" 
            self.start
        end 
    end 

    def book_now
        puts "Please enter the date you would like to book your activity for: (mm/dd/yyyy)"
        puts "----------------------------------------------------------------------------".cyan
        date = STDIN.gets.chomp
        user = Tourist.find_by(username: @username).id
        park_id = Nationalpark.find_by(name: @user_park).id 
        Activity.create(activity: @activity,nationalpark_id: park_id,tourist_id: user,date: date)
        puts "Thank you for booking your activity with ActivityRecord!"
        puts "--------------------------------------------------------".cyan
        self.start
    end 
        

    def exit
        puts 'Thanks for visiting!'
        puts "ʕ •ᴥ•ʔ".red
        puts "ONLY YOU CAN PREVENT WILDFIRES".red
    end 
end 