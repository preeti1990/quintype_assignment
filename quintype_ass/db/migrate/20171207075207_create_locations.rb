class CreateLocations < ActiveRecord::Migration[5.0]
  def change
    create_table :locations do |t|
      t.float :lat
      t.float :lng
      t.string :street_address
      t.string :sublocality
      t.string :city
      t.string :state
      t.string :zipcode
      t.string :country
      t.string :landmark

      t.timestamps
    end
  end
end
