class AddServiceTypeIdToCab < ActiveRecord::Migration[5.0]
  def change
    add_reference :cabs, :service_type, foreign_key: true
  end
end
