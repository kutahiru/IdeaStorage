class User < ApplicationRecord
  has_many :categories
  has_many :ideas, through: :categories

  validates :name,  presence: true

  devise :omniauthable, omniauth_providers: [ :google_oauth2 ]

  def category_ideas(category_id)
    ideas.where(category_id: category_id)
  end

  # Googleから取得した情報を保存するためのカラムとの関連付け
  def self.from_google(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.name = auth.info.name
    end
  end
end
