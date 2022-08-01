class CreateWills < ActiveRecord::Migration[7.0]
  def change
    create_table :wills do |t|
      t.references :user, null: false, foreign_key: true
      t.boolean :is_public, null: false, default: false
      t.boolean :is_prepaid, null: false, default: false

      t.timestamps
    end
  end
end
