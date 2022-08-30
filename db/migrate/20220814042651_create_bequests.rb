class CreateBequests < ActiveRecord::Migration[7.0]
  def change
    create_table :bequests do |t|
      t.references :asset, null: false, index: true
      t.references :beneficiariable, polymorphic: true, null: false, index: true

      t.timestamps
    end
  end
end
