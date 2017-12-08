class CreateCabs < ActiveRecord::Migration[5.0]
  def change
    create_table :cabs do |t|
      t.string :name
      t.string :classie_no
      t.string :reg_no
      t.string :insurance_no
      t.string :model
      t.string :no_of_seats
      t.string :owner_name
      t.string :owner_address
      t.datetime :reg_date
      t.string :wheels
      t.string :color
      t.boolean :active
      t.string :fuel
      t.string :permit_type
      t.string :vehicle_type

      t.timestamps
    end
  end
end
