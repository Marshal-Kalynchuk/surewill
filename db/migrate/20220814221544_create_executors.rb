class CreateExecutors < ActiveRecord::Migration[7.0]
  def change
    create_table :executors do |t|
      t.references :delegate, null: false, foreign_key: true
      t.references :will, null: false, foreign_key: true
      t.integer :rank, null: false

      t.timestamps
    end
  end
end
