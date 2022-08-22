class CreateAddresses < ActiveRecord::Migration[7.0]
  def change
    create_table :addresses do |t|
      t.string :line_1
      t.string :line_2
      t.string :zone, null: false
      t.string :postal_code
      t.string :city, null: false
      t.string :country_code, null: false

      t.timestamps
    end
  end
end
