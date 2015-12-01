class UsersController < ApplicationController
  
  def show # 追加
   @user = User.find(params[:id])
   if @user == current_user
     
     else
       redirect_to root_url,  alert: "不正なアクセス"
      
   end
   
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
    @user = User.find(params[:id])
    if @user == current_user
     
     else
       redirect_to root_url,  alert: "不正なアクセス"
      
    end
    
  end

  def update
     @user = User.find(params[:id])
      if @user.update(user_params)
        redirect_to user_url(@user)
      else
        render 'edit'
      end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password,
                                 :password_confirmation)
  end
end