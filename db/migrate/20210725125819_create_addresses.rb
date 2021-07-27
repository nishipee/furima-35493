class CreateAddresses < ActiveRecord::Migration[6.0]
  def change
    create_table :addresses do |t|
      t.string :postcode,             null: false
      t.integer :area_id,             null: false
      t.string :city,                 null: false
      t.string :address,              null: false
      t.string :building_name
      t.string :phone_num,            null: false
      t.references :purchase_history, foreign_key: true

      t.timestamps
    end
  end
end
