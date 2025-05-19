class Category < ApplicationRecord
  enum status: {
    normal: "0", # 通常
    disabled: "1" # 無効
  }
  belongs_to :user
  has_many :ideas

  validates :title, presence: true, length: { maximum: 50, message: "50文字以内で入力してください" }
  validates :body, length: { maximum: 1000, message: "1000文字以内で入力してください" }

  def self.ransackable_attributes(auth_object = nil)
    %w[title body]
  end

  def self.ransackable_associations(auth_object = nil)
    [ "ideas", "user" ]
  end
end
