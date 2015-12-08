class MicropostsController < ApplicationController
    before_action :logged_in_user, only: [:create, :destroy] #createアクションの時だけApplicationControllerにあるlogged_in_userを実行
     
 def create
    @micropost = current_user.microposts.build(micropost_params)
    if @micropost.save
      flash[:success] = "Micropost created!"
      redirect_to root_url
    else
      render 'static_pages/home'
    end
 end
 
 def destroy
    @micropost = current_user.microposts.find_by(id: params[:id])
    return redirect_to root_url if @micropost.nil?
    @micropost.destroy
    flash[:success] = "Micropost deleted"
    redirect_to request.referrer || root_url
 end
  
  private #paramsに:micropostというキーが存在するか検証し、存在する場合はparams[:micropost]のうち、キーが:contentの値のみ受け取る
  def micropost_params
    params.require(:micropost).permit(:content)
  end
end


#