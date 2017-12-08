class CreateCabFacilities < ActiveRecord::Migration[5.0]
  def change
    create_table :cab_facilities do |t|
      t.references :cab, foreign_key: true
      t.references :facility, foreign_key: true

      t.timestamps
    end
  end
end
