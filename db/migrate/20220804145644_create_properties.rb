class CreateProperties < ActiveRecord::Migration[7.0]
  def change
    create_table :properties do |t|
      t.references :will, null: false, foreign_key: true
      t.string :property_type, null: false
      t.string :title, null: false
      
      t.timestamps
    end
  end
end
