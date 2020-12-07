class AddUsernameColumnToTourists < ActiveRecord::Migration[6.0]
  def change
    add_column :tourists, :username, :string
  end
end
