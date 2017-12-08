class AddOtpToRide < ActiveRecord::Migration[5.0]
  def change
    add_column :rides, :otp, :string
  end
end
