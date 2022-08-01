class CreateSubscriptions < ActiveRecord::Migration[7.0]
  def change
    create_table :subscriptions do |t|
      t.references :user, foreign_key: true
      t.references :will, null: false, foreign_key: true
      t.boolean :is_payed, null:false, default: false

      t.timestamps
    end
  end
end
