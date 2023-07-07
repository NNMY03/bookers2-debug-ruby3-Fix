class Book < ApplicationRecord
  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy
  
  validates :title, presence: true
  validates :body, presence: true, length: { maximum: 200 }
  
  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end
  
  # 並べ替え
  scope :latest, -> {order("created_at desc")}
  scope :star_count, -> {order("star desc")}
  
  # Bookテーブル検索方法分岐
  def self.looks(search, word)
      # 完全一致
    if search == "perfect_match"
      @book = Book.where("title LIKE?", "#{word}")
      # 前方一致
    elsif search == "forward_match"
      @book = Book.where("title LIKE?", "#{word}%")
      # 後方一致
    elsif search == "backward_match"
      @book = Book.where("title LIKE?", "%#{word}")
      # 部分一致
    elsif search == "partial_match"
      @book = Book.where("title LIKE?", "%#{word}%")
    else
      @book = Book.all
    end
  end
end