class CreateMedia < ActiveRecord::Migration[5.0]
  def change
    create_table :media do |t|
      t.references :owner, polymorphic: true

      t.timestamps
    end
  end
end
