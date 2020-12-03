class Permits < ActiveRecord::Migration[6.0]
  def change
    create_table :permits do |t|
      t.timestamps
      t.integer :nationalpark_id
      t.integer :tourist_id
    end 
  end
end
