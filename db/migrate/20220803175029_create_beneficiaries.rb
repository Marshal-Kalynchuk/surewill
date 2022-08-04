class CreateBeneficiaries < ActiveRecord::Migration[7.0]
  def change
    create_table :beneficiaries do |t|
      t.references :will, null: false, foreign_key: true
      t.string :name, null: false

      t.timestamps
    end
  end
end
