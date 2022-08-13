class CreateBeneficiaries < ActiveRecord::Migration[7.0]
  def change
    create_table :beneficiaries do |t|

      t.references :will, null: false, foreign_key: true
      t.string :role, null: false
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.text :note

      t.timestamps
    end
  end
end
