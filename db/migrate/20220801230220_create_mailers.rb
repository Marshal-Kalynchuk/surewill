class CreateMailers < ActiveRecord::Migration[7.0]
  def change
    create_table :mailers do |t|
      t.string :email, null: false, default: ""

      t.timestamps
    end
    add_index :mailers, :email, unique: true
  end
end
