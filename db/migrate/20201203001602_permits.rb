class Permits < ActiveRecord::Migration[6.0]
  def change
    create_table :permits do |t|
      t.integer :nationalpark_id
      t.integer :tourist_id
      t.timestamps
    end 
  end
end
