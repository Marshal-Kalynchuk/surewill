class CreateCollocations < ActiveRecord::Migration[7.0]
  def change
    create_table :collocations do |t|
      t.references :address, null: false
      t.references :collocable, polymorphic: true, null: false, index: true

      t.timestamps
    end
  end
end
