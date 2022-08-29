class AddCountsToWill < ActiveRecord::Migration[7.0]
  def change
    add_column :wills, :assets_count, :integer
    add_column :wills, :delegates_count, :integer
    add_column :wills, :dependents_count, :integer
  end
end
