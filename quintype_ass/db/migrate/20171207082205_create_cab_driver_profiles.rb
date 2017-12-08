class CreateCabDriverProfiles < ActiveRecord::Migration[5.0]
  def change
    create_table :cab_driver_profiles do |t|
      t.string :phone
      t.string :otp
      t.float :avg_user_rating
      t.string :experience
      t.string :driving_liscence_no
      t.string :aadhar_no
      t.boolean :verified

      t.timestamps
    end
  end
end
