module Api
    module V1
    class FollowsController < ApplicationController
    def create
    user = User.find(params[:user_id])
    current_user.following << user unless current_user.following.exists?(user.id)
    Notification.create!(user: user, actor: current_user, action: 'followed', notifiable: current_user)
    head :created
    end
    
    
    def destroy
    user = User.find(params[:user_id])
    current_user.following.destroy(user)
    head :no_content
    end
    
    
    def followers
    user = User.find(params[:user_id])
    followers = user.followers.page(params[:page])
    render json: followers, each_serializer: UserSerializer, meta: { page: followers.current_page, total_pages: followers.total_pages }
    end
    
    
    def following
    user = User.find(params[:user_id])
    following = user.following.page(params[:page])
    render json: following, each_serializer: UserSerializer, meta: { page: following.current_page, total_pages: following.total_pages }
    end
    end
    end
    end