class ChangeNameToFirstnameAddColumnLastname < ActiveRecord::Migration[6.0]
  def change
    rename_column :tourists, :name, :first_name
    add_column :tourists, :last_name, :string
  end
end
