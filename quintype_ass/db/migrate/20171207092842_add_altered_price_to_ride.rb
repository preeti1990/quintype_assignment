class AddAlteredPriceToRide < ActiveRecord::Migration[5.0]
  def change
    add_column :rides, :altered_price, :float
    add_reference :rides, :seat, foreign_key: true
  end
end
