class CreateKnownLanguages < ActiveRecord::Migration[5.0]
  def change
    create_table :known_languages do |t|
      t.string :name
      t.references :cab_driver_profile, foreign_key: true

      t.timestamps
    end
  end
end
