class BooksController < ApplicationController

  def new
    @book = Book.new
  end

  def show
    @booknew = Book.new
    @book = Book.find(params[:id])
    @user = @book.user
    @book_comment = BookComment.new
  end

  def index
    @book = Book.new
    @books = Book.all

# if分とelsifで条件の追記を行う
#モデルで設定したlatestメソッドの値を取得
  if params[:latest]
#インスタンス変数にBookモデルのlatestカラムの値を渡す
    @books = Book.latest
#条件の追加
  elsif params[:star_count]
    @books = Book.star_count
#条件終了後allデータを取得する
  else
    @books = Book.all
  end

  end

  def create
    @user = current_user
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      flash[:notice] = "You have created book successfully."
      redirect_to book_path(@book.id)
    else
      @books = Book.all
      render 'index'
    end
  end

  def edit
    @book = Book.find(params[:id])
    unless @book.user.id == current_user.id
      redirect_to books_path
    end
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      flash[:notice] = "You have updated book successfully."
      redirect_to book_path(@book.id)
    else
      render :edit
    end

    unless @book.user.id == current_user.id
      redirect_to users_path
    end

  end

  def destroy
    @user = current_user
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end

  private

  def book_params
    params.require(:book).permit(:title, :body, :comment, :star, :latest, :category)
  end
end
