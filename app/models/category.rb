class Category < ApplicationRecord
  belongs_to :user
  has_many :ideas

  validates :title, presence: true
end
