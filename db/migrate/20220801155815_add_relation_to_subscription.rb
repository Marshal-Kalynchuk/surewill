class AddRelationToSubscription < ActiveRecord::Migration[7.0]
  def change
    add_column :subscriptions, :relation, :string
  end
end
