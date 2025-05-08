class Idea < ApplicationRecord
  belongs_to :category

  enum rank: {
    low: "0",
    medium: "1",
    high: "2"
  }

  validates :idea_kbn, :title, presence: true
  validates :sort, numericality: true
end
