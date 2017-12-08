class ServiceType < ApplicationRecord
  validates :name, :price, :presence => true
end
