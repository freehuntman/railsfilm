class Film < ApplicationRecord
  validates :title, :description, presence: true
end
