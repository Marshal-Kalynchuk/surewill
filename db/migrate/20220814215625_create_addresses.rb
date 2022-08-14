class CreateAddresses < ActiveRecord::Migration[7.0]
  def change
    create_table :addresses do |t|
      t.string :line_1, null: false
      t.string :line_2
      t.string :zone_code
      t.string :postal_code
      t.string :city, null: false
      t.string :country_code
      t.string :country, null: false

      t.timestamps
    end
  end
end
