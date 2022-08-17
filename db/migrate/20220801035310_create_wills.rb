class CreateWills < ActiveRecord::Migration[7.0]
  def change
    create_table :wills do |t|
      t.references :user, null: false, foreign_key: true
      t.boolean :released, null: false, default: false
      t.boolean :prepaid, null: false, default: false
      t.string :status, null: false

      t.timestamps
    end
  end
end
