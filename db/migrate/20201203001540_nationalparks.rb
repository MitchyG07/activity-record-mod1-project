class Nationalparks < ActiveRecord::Migration[6.0]
  def change
    create_table :nationalparks do |t|
      t.string :name
      t.string :code
      t.text :description
      t.string :location
      t.string :designation
      t.text :weather
      t.timestamps
    end 
  end
end
