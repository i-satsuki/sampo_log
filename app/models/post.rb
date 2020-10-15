class Post < ApplicationRecord
  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :comments, dependent: :destroy

  attachment :image

  validates :title, presence: true
  validates :body, presence: true
  validates :steps, presence: true, numericality: true

  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end
end
