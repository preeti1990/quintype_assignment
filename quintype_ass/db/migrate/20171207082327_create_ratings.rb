class CreateRatings < ActiveRecord::Migration[5.0]
  def change
    create_table :ratings do |t|
      t.references :user, foreign_key: true
      t.references :ride, foreign_key: true
      t.float :star_rating
      t.string :comment

      t.timestamps
    end
  end
end
