class Addstatescolumntonationalpark < ActiveRecord::Migration[6.0]
  def change
    add_column :nationalparks, :states, :string
  end
end
