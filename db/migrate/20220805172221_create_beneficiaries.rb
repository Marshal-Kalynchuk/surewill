class CreateBeneficiaries < ActiveRecord::Migration[7.0]
  def change
    create_table :beneficiaries do |t|
      t.references :will, null: false, foreign_key: true
      t.references :delegate, null: false, foreign_key: true

      t.timestamps
    end
  end
end
