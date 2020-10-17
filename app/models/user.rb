class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :posts, dependent: :destroy
  # Relationshipモデルのfollower_idにuser_idを格納する
  has_many :follower, class_name: 'Relationship', foreign_key: 'follower_id', dependent: :destroy
  has_many :followed, class_name: 'Relationship', foreign_key: 'followed_id', dependent: :destroy
  has_many :following_user, through: :follower, source: :followed
  has_many :follower_user, through: :followed, source: :follower
  has_many :favorites, dependent: :destroy
  has_many :comments, dependent: :destroy

  attachment :profile_image

  validates :name, presence: true
  validates :uid, presence: true, length: { in: 2..20 }, uniqueness: true
  validates :introduction, length: { maximum: 50 }
  validates :target_number, numericality: {only_integer: true, greater_than: 0}

  # ユーザーをフォローする
  def follow(user_id)
    follower.create(followed_id: user_id)
  end

  # ユーザーをアンフォローする
  def unfollow(user_id)
    follower.find_by(followed_id: user_id).destroy
  end

  # フォローしているかを確認する
  def following?(user)
    following_user.include?(user)
  end

  # is_deletedがfalseの場合（有効会員）、ログイン可能
  def active_for_authentication?
    super && (is_deleted == false)
  end
end
