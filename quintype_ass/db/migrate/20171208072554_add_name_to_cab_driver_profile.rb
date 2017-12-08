class AddNameToCabDriverProfile < ActiveRecord::Migration[5.0]
  def change
    add_column :cab_driver_profiles, :name, :string
  end
end
