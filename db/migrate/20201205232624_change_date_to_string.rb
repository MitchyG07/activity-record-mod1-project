class ChangeDateToString < ActiveRecord::Migration[6.0]
  def change
    change_column :activities, :date, :string
  end
end
