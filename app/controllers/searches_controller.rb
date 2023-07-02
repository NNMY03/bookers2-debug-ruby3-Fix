class SearchesController < ApplicationController
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
end
