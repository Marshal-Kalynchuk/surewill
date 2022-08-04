class CreateBeneficiaries < ActiveRecord::Migration[7.0]
  def change
    create_table :beneficiaries do |t|
      t.references :user, null: false, foreign_key: true
      t.references :will, null: false, foreign_key: true
      t.boolean :payed

      t.timestamps
    end
  end
end
