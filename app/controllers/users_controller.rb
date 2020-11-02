class UsersController < ApplicationController
	before_action :authenticate_user!

  def index
    @user = current_user
    @users = User.all
    @book = Book.new
  end
  
  def show
  	@user = User.find(params[:id])
    @book = Book.new
    @books = Book.all
  end

  def edit
    user = User.find(params[:id])
    if user == current_user
      @user = User.find(params[:id])
    else
      redirect_to user_path(current_user)
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
    	flash[:notice] = "You have updated user successfully."
    	redirect_to user_path(@user.id)
    else
      flash[:notice] = "error"
    	render action: :edit
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end

  def book_params
	  params.require(:book).permit(:title, :body)
  end
end
