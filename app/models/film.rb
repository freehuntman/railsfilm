class Film < ApplicationRecord
  belongs_to :user
  has_many :reviews
  validates :title, :description, presence: true

  has_many :film_relationships
  has_many :members, through: :film_relationships, source: :user
end
