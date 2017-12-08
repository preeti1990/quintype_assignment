class AddCabDriverIdToCab < ActiveRecord::Migration[5.0]
  def change
    add_reference :cabs, :cab_driver_profile, foreign_key: true
  end
end
