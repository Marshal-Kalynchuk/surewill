class CreateDelegates < ActiveRecord::Migration[7.0]
  def change
    create_table :delegates do |t|
      t.references :will, null: false, foreign_key: true
      t.string :first_name, null:false
      t.string :middle_name
      t.string :last_name, null:false
      t.string :relation, null:false
      t.text :note

      t.timestamps
    end
  end
end
