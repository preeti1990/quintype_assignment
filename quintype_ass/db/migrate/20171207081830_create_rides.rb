class CreateRides < ActiveRecord::Migration[5.0]
  def change
    create_table :rides do |t|
      t.datetime :ride_time
      t.float :amount
      t.boolean :amount_paid
      t.datetime :start_time
      t.datetime :end_time
      t.integer :source_location_id
      t.integer :destination_location_id
      t.string :ride_state

      t.timestamps
    end
  end
end
