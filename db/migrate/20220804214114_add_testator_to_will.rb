class AddTestatorToWill < ActiveRecord::Migration[7.0]
  def change
    add_column :wills, :testator, :string, null: false
  end
end
