class CreateSubcriptions < ActiveRecord::Migration[7.0]
  def change
    create_table :subcriptions do |t|
      t.references :user, null: false, foreign_key: true
      t.references :will, null: false, foreign_key: true
      t.boolean :payed, null: false, default: false

      t.timestamps
    end
  end
end
