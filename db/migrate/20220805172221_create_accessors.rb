class CreateAccessors < ActiveRecord::Migration[7.0]
  def change
    create_table :accessors do |t|

      t.references :will, null: false, foreign_key: true
      t.boolean :can_release, null: false, default: false
      t.string :email, null: false
      t.string :role, null: false
      t.string :name, null: false

      t.timestamps
    end
  end
end
