class Name < ApplicationRecord
  has_many :reservations
  validates :value, presence: true, uniqueness: true
end
