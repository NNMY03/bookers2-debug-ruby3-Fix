class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  has_many :books, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy

#フォローした、された関係性
has_many :give_relationships, class_name: "Relationship",foreign_key: "followed_id", dependent: :destroy
has_many :take_relationships, class_name: "Relationship",foreign_key: "follower_id", dependent: :destroy

#どのテーブルとアソシエーションしているか指定する
#foreign_kyeの後ろには関連付けるカラム名を入力する

has_many :giv_followed, through: :give_relationships, source: :followed
has_many :take_follower, through: :take_relationships, source: :follower

# フォローしたときの処理
def follow(user_id)
  take_relationships.create(followed_id: user_id)
end

# フォローを外した時の処理
def unfollow(user_id)
  take_relationships.find_by(followed_id: user_id).destroy
end

#フォローしているか判定
def giv_followed?(user)
  giv_followed.include?(user)
end
  
  has_one_attached :profile_image

  validates :name, presence: true

  validates :name, length: { minimum: 2, maximum: 20 }, uniqueness: true
  validates :introduction, length: { maximum: 50 }, uniqueness: true
  
  
  def get_profile_image
    (profile_image.attached?) ? profile_image : 'no_image.jpg'
  end
end
