class Media < ApplicationRecord
  belongs_to :owner, polymorphic: true
  validates :owner_id, :owner_type ,:presence => true
end
