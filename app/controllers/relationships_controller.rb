class RelationshipsController < ApplicationController
  # フォローするとき
  def create
    current_user.follow(params[:user_id])
    redirect_to request.referer
  end
  
  # ふぉろーはずすとき
  def destroy
    current_user.unfollow(params[:user_id])
    redirect_to request.referer
  end
  
  # フォロー一覧表示
  def giv_followed
    user = User.find(params[:user_id])
    @users = user.followings
  
  end
  
  # フォロワー一覧表示
  def take_follower
    user = User.find(params[:user_id])
    @users = user.followings
  end
end
