class CreateFinances < ActiveRecord::Migration[7.0]
  def change
    create_table :finances do |t|
      t.references :will, null: false, foreign_key: true
      t.string :finance_type
      t.string :bank_name
      t.string :account_type

      t.timestamps
    end
  end
end
