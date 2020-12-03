class Tourists < ActiveRecord::Migration[6.0]
  def change
    create_table :tourists do |t|
      t.string :name
    end 
  end
end
