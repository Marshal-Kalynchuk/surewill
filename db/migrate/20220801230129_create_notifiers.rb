class CreateNotifiers < ActiveRecord::Migration[7.0]
  def change
    create_table :notifiers do |t|
      t.references :will, null: false, foreign_key: true
      t.references :mailer, null: false, foreign_key: true
      t.string :role
      t.timestamps
    end
  end
end
