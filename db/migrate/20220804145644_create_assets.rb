class CreateAssets < ActiveRecord::Migration[7.0]
  def change
    create_table :assets do |t|
      t.references :will, null: false, foreign_key: true
      t.string :asset_type, null: false
      t.string :title, null: false
      t.text :description, null: false
      
      t.timestamps
    end
  end
end
