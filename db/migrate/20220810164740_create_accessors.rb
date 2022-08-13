class CreateAccessors < ActiveRecord::Migration[7.0]
  def change
    create_table :accessors do |t|
      
      t.references :user, null: false, foreign_key: true
      t.references :will, null: false, foreign_key: true
      t.boolean :can_release, null: false, default: false
      t.boolean :payed, null: false, default: false

      t.timestamps
    end
  end
end
