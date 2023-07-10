class Book < ApplicationRecord
  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy
  
  validates :title, presence: true
  validates :category, presence: true
  validates :body, presence: true, length: { maximum: 200 }
  
  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end
  
  # 投稿数表示
  scope :today_count, -> {where(created_at: Time.zone.now.all_day)}
  scope :agoday_count, -> {where(created_at: 1.day.ago.all_day)}
  scope :toweek_count, -> {where(created_at: 6.day.ago.beginning_of_day..Time.zone.now.end_of_day) } 
  scope :agoweek_count, -> {where(created_at: 2.week.ago.beginning_of_day..1.week.ago.end_of_day) } 
  
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
  
  # タグ検索
  def self.search(search_word)
    Book.where(['category LIKE ?', "#{search_word}"])
  end
end