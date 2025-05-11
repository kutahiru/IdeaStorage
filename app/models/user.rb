class User < ApplicationRecord
  has_many :categories

  validates :name,  presence: true

  devise :omniauthable, omniauth_providers: [ :google_oauth2 ]

  # Googleから取得した情報を保存するためのカラムとの関連付け
  def self.from_google(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.name = auth.info.name
    end
  end
end
