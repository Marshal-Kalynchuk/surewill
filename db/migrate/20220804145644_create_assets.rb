class CreateAssets < ActiveRecord::Migration[7.0]
  def change
    create_table :assets do |t|
      t.references :will, null: false, foreign_key: true
      t.string :title, null: false
      t.string :description
      
      t.timestamps
    end
  end
end
