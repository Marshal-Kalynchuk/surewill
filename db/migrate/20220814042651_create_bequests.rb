class CreateBequests < ActiveRecord::Migration[7.0]
  def change
    create_table :bequests do |t|
      t.integer :percentage, null: false, default: 10000
      t.string :primary, null: false, default: true
      t.references :asset,  polymorphic: true, null: false, index: true
      t.references :beneficiariable, polymorphic: true, null: false, index: true

      t.timestamps
    end
  end
end
