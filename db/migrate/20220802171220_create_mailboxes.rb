class CreateMailboxes < ActiveRecord::Migration[7.0]
  def change
    create_table :mailboxes do |t|
      t.string :email, null: false, default: ""
      t.boolean :deliverable, null: false, default: true

      t.boolean :receive_promotions, null: false, default: true
      t.boolean :receive_notifications, null: false, default: true
      
      t.references :user, null: true, foreign_key: true

      t.timestamps
    end
    add_index :mailboxes, :email, unique: true
  end
end
