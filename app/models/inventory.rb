class Inventory < ApplicationRecord
  belongs_to :User
  has_many :inventory_foods, dependent: :destroy
  has_many :foods, through: :inventory_foods

  validates :name, presence: true, length: { minimum: 3, maximum: 50 }
  validates :user_id, presence: true
  validates :description, presence: true, length: { minimum: 3, maximum: 250 }
end
