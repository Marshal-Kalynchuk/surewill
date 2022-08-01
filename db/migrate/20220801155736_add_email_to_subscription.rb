class AddEmailToSubscription < ActiveRecord::Migration[7.0]
  def change
    add_column :subscriptions, :email, :string, null: false
  end
end
