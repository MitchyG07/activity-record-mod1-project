class AddDateToActivityForBooking < ActiveRecord::Migration[6.0]
  def change
    add_column :activities, :date, :datetime
  end
end
