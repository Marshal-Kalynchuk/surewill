class AddCountsToWill < ActiveRecord::Migration[7.0]
  def change
    add_column :wills, :properties_count, :integer
    add_column :wills, :finances_count, :integer
    add_column :wills, :delegates_count, :integer
  end
end
