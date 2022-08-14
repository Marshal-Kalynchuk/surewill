class CreateTestators < ActiveRecord::Migration[7.0]
  def change
    create_table :testators do |t|
      t.references :will, null: false, foreign_key: true
      t.string :first_name, null: false
      t.string :middle_name, default: ""
      t.string :last_name, null: false

      t.timestamps
    end
  end
end
