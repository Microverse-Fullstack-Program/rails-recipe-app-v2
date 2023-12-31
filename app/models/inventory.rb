class Inventory < ApplicationRecord
  belongs_to :user, class_name: 'User', foreign_key: 'user_id'
  has_many :inventory_foods, dependent: :destroy
  has_many :foods, through: :inventory_foods

  validates :name, presence: true, uniqueness: { case_sensitive: false }, length: { minimum: 3, maximum: 50 }
  validates :description, presence: true, length: { minimum: 3, maximum: 500 }
end
