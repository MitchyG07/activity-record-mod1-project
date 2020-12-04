class Activities < ActiveRecord::Migration[6.0]
  def change
    create_table :activities do |t|
      t.string :activity
      t.integer :nationalpark_id
      t.integer :tourist_id
      t.timestamps
    end 
  end
end
