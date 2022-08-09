class AddCanReleaseToAccessor < ActiveRecord::Migration[7.0]
  def change
    add_column :accessors, :can_release, :boolean, null: false, default: false
  end
end
