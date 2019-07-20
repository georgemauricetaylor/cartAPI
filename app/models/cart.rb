class Cart < ApplicationRecord

  has_one :product

  validates :title, presence: true
  validates :price, presence: true


end

