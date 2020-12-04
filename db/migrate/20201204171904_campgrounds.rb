class Campgrounds < ActiveRecord::Migration[6.0]
  def change
    create_table :campgrounds do |t|
      t.string :name
      t.text :description
      t.string :park_code
      t.integer :nationalpark_id
    end
  end
end
