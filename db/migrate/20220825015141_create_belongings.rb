class CreateBelongings < ActiveRecord::Migration[7.0]
  def change
    create_table :belongings do |t|
      t.references :will, null: false, foreign_key: true
      t.string :title
      t.string :description

      t.timestamps
    end
  end
end
