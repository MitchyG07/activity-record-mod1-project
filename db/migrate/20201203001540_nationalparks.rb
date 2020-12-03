class Nationalparks < ActiveRecord::Migration[6.0]
  def change
    create_table :nationalparks do |t|
      t.string :name
      t.string :state
      t.text :activities 
      t.integer :contact
      t.float :fee
      t.string :address
      t.string :weather
      t.text :campground
      t.float :latitude 
      t.float :longitude 
      t.text :description
    end 
  end
end
