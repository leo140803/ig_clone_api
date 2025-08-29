module Api
    module V1
    class LikesController < ApplicationController
    def create
    likeable = find_likeable
    likeable.likes.create!(user: current_user)
    head :created
    end
    
    
    def destroy
    likeable = find_likeable
    like = likeable.likes.find_by!(user: current_user)
    like.destroy
    head :no_content
    end
    
    
    private
    
    
    def find_likeable
    if params[:post_id]
    Post.find(params[:post_id])
    elsif params[:comment_id]
    Comment.find(params[:comment_id])
    else
    raise ActiveRecord::RecordNotFound, 'likeable not found'
    end
    end
    end
    end
    end