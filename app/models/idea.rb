class Idea < ApplicationRecord
  belongs_to :category

  enum rank: {
    low: "0",
    medium: "1",
    high: "2"
  }
  enum status: {
    normal: "0", # 通常
    disabled: "1", # 無効
    adopted: "2" # 採用
  }

  validates :idea_kbn, :title, presence: true
  validates :sort, numericality: true

  def self.ransackable_attributes(auth_object = nil)
    %w[title body]
  end

  def self.ransackable_associations(auth_object = nil)
    [ "category", "user" ]
  end
end
