# Module One Final Project#

# Name
ActivityRecord

# Goal 
ActivityRecord allows users to search and book activities at various public parks across the US. 

# Description
Users login and have the option to view and manage their previous bookings or search for new activities. Users can search by park or state to see if that activity is available for booking. Users can broaden the search by viewing a full list of parks and their states with a given activity. A user can further delve into park information before booking an activity.

# Prerequisites
Before you continue, ensure you have met the following requirements:

* Have a basic environment configured 
* Have a code editor 

# How to Install
* Clone the repository: https://github.com/MitchyG07/activity-record-mod1-project
  in your terminal
* In your terminal:
  * cd into the directory
  * Type 'bundle install'
  * Type 'rake db:migrate'
  * Type 'rake db:seed'
  * Run the program by typing 'ruby bin/run.rb' in your terminal
* Now the program has started!


# How to Use ActivityRecord
* The program opens with a welcome and prompts the user to enter their first and last name.
* On the main menu:
  * Press 1 to explore activities to book
  * Press 2 to view and manage your past bookings
  * Press 3 to exit the application
* To explore/book:
  * View the entire list of available activities
  * Input the activity of your choice
    * Press 1 to search for a specific park
      * Input the park you'd like to book your activity
      * If the park has your activity, you can book the activity and/or view information on the park
    * Press 2 to search by state
      * Enter the two character state code 
      * View a list of all parks with your activity available in that state
      * Input which park you'd like to book your activity
      * Book the activity and/or view information on the park
    * Press 3 to view a list of every park and its state with your activity
      * View a list of all parks and their state with your activity available
      * Input which park you'd like to book your activity
      * Book the activity and/or view information on the park
    * Press 4 to return to the main menu
    * Press 5 to exit
  * To book an activity
    * After a successful search, press 6 to book your activity on the parks menu
    * Enter the date you'd like to do your activity
* To view/manage your bookings:
  * View list of all your previous bookings
  * Press 1 to delete a booking
    * Enter the id # of the booking you would like to delete
  * Press 2 to update a booking
    * Enter the id # of the booking you would like to update
    * Enter the new date for your booked activity
  
  Created by: Emma Fewer (github: emmafewer) and Mitch Gilbert (github: MitchyG07)


  

