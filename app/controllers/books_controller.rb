class BooksController < ApplicationController
	before_action :authenticate_user!

  def index
  	@users = User.all
  	@user = current_user
  	@books = Book.all
  	@book = Book.new
  end

  def show
  	@book = Book.find(params[:id])
  	@newbook = Book.new
  	@user = current_user
  end

  def edit
  	book = Book.find(params[:id])
  	if book.user == current_user
  		@book = Book.find(params[:id])
  	else
  		redirect_to books_path
  	end
  end
  
  def create
  	@book = Book.new(book_params) #index view in create action
  	@book.user_id = current_user.id
  	if @book.save
  		@user = current_user
  		flash[:notice] = "You have created book successfully."
  		redirect_to book_path(@book.id)
  	else
  		@users = User.all
  		@user = current_user
  		@user.introduction = current_user.introduction
  		@books = Book.all
  		flash[:notice] = "error"
  		render action: :index
  	end
  end

  def update
  	@book = Book.find(params[:id])
  	if @book.update(book_params)
  		flash[:notice] = "Book was successfully updated."
  		redirect_to book_path(@book.id)
  	else
  		flash[:notice] = "error"
  		render action: :edit
  	end
  end

  def destroy
  	book = Book.find(params[:id])
  	book.destroy
  	flash[:notice] = "Book was successfully destroyed."
  	redirect_to books_path
  end

  private

  def book_params
  	params.require(:book).permit(:title, :body, :user_id)
  end

  def user_params
	  params.require(:user).permit(:name, :profile_image, :introduction)
  end
end
