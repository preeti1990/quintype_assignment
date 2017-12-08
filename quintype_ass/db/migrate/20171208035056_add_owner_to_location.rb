class AddOwnerToLocation < ActiveRecord::Migration[5.0]
  def change
    add_reference :locations, :owner, polymorphic: true
  end
end
