class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :posts, dependent: :destroy
  attachment :profile_image

  validates :name, presence: true
  validates :uid, presence: true, length: { in: 2..20 }
  validates :introduction, length: { maximum: 50 }

  # is_deletedがfalseの場合（有効会員）、ログイン可能
  def active_for_authentication?
      super && (self.is_deleted == false)
  end
end
