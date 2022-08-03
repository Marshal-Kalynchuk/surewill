class AddVisibleToSubscription < ActiveRecord::Migration[7.0]
  def change
    add_column :subscriptions, :visible, :boolean, null: false, default: true
  end
end
