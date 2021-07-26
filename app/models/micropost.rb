class Micropost < ApplicationRecord
  belongs_to :user
  validates :content, presence: true, length: { maximum: 255 }
  
  has_many :favorites
  has_many :users, through: :favorites #favoriteモデルを経由してuser
  has_many :favorite_users, through: :favorites, source: :user
end
