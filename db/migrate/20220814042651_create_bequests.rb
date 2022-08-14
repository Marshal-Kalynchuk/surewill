class CreateBequests < ActiveRecord::Migration[7.0]
  def change
    create_table :bequests do |t|
      t.float :percentage, null: false
      t.references :asset, null: false
      t.references :benefactor, polymorphic: true, null: false, index: true

      t.timestamps
    end
  end
end
