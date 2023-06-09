class UsersController < ApplicationController
  before_action :ensure_correct_user, only: [:update, :edit]
  before_action :ensure_guest_user, only: [:edit]
 
  def show
    @user = User.find(params[:id])
    @books = @user.books
    @book = Book.new
  end

  def index
    @users = User.all
    @book = Book.new
    @user = current_user
  end

  def edit
    @user = User.find(params[:id])
   unless @user.id == current_user.id
     redirect_to user_path(current_user.id)
   end
  end

  def create
    @user = User.new(user_params)
    if @user.save
        flash[:notice] = "You have updated user successfully"
     redirect_to user_path(@user.id)
    else
     render :new
    end
  end


  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
        flash[:notice] = "You have updated user successfully."
      redirect_to user_path(@user.id)
    else
      render :edit
    end
  end

  def followers
    @user = User.find(params[:id])
    @users = @user.followers
      render :"relationships/follower" 
  end

  def followeds
    @user = User.find(params[:id])
    @users = @user.followings
      render :"relationships/follow" 
  end

  private

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

  def is_matching_login_user
    user = current_user
    unless user.id == current_user.id
      redirect_to book_path(current_user.id)
    end
  end

  #def ensure_correct_user
   # @user = User.find(params[:id])
   # if @user != current_user
    #  redirect_to books_path
   # end
 # end
#end

def ensure_correct_user
  @user = User.find(params[:id])
  unless @user == current_user
  redirect_to user_path(current_user)
  end
end

def ensure_guest_user
    @user = User.find(params[:id])
    if @user.name == "guestuser"
      redirect_to user_path(current_user) , notice: 'ゲストユーザーはプロフィール編集画面へ遷移できません。'
    end
end  


end