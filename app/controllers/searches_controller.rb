class SearchesController < ApplicationController
before_action :authenticate_user!

  def search
    @range = params[:range] #検索モデル
    @word = params[:word]   #検索ワード
   if @range == "User"
    @users = User.looks(params[:search], params[:word])#[:seach]=検索方法
    #@usersにUserモデル内の検索結果を代入する
   else
    @books = Book.looks(params[:search], params[:word])#looksメソッドは検索内容の取得
    #@booksにBookモデル内の検索結果を代入する
   end
  end
  
#   タグ検索窓用に新しくアクションを作成
  def search_book
    @model = Book  #search機能とは関係なし
    @word = params[:word]
    @books = Book.where("category LIKE?","%#{@word}%")
    render searches_search_path
  end

end
