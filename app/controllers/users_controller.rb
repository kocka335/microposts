class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :followings, :followers]
  before_action :correct_user, only: [:edit, :update, :destroy]
  
  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.order(created_at: :desc)
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
       flash[:success] = "Welcome to Microposts!"
       redirect_to @user # ここを修正
    else
      render 'new'
    end
  end

  def edit
  
  end

  def update
    if @user.update(user_params)
      redirect_to user_url(@user)
    else
      render :edit
    end
  end

  def followings
    @followings = @user.following_users.order(created_at: :desc)
  end

  def followers
    @followers = @user.follower_users.order(created_at: :desc)
  end
  
  private

  def user_params
    params.require(:user).permit(:name, :email, :location, :password,
                                 :password_confirmation)
  end
  
  def set_user
    @user = User.find(params[:id])
  end
  
  def correct_user
    if logged_in?
      unless current_user == @user  #イコールでなければ↓を実行
        redirect_to root_url, alert: '不正なアクセス'
      end
    else
      redirect_to root_url, alert: 'ログインしてください'
    end
  end
  

end