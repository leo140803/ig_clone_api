module Api
    module V1
    class CommentsController < ApplicationController
    def index
    post = Post.find(params[:post_id])
    comments = post.comments.includes(:user).order(created_at: :asc).page(params[:page])
    render json: comments, each_serializer: CommentSerializer, meta: { page: comments.current_page, total_pages: comments.total_pages }
    end
    
    
    def create
    post = Post.find(params[:post_id])
    comment = post.comments.build(comment_params.merge(user: current_user))
    if comment.save
    Notification.create!(user: post.user, actor: current_user, action: 'commented', notifiable: comment) unless post.user == current_user
    render json: CommentSerializer.new(comment), status: :created
    else
    render json: { errors: comment.errors.full_messages }, status: :unprocessable_entity
    end
    end
    
    
    def destroy
    comment = current_user.comments.find(params[:id])
    comment.destroy
    head :no_content
    end
    
    
    private
    
    
    def comment_params
    params.require(:comment).permit(:body, :parent_id)
    end
    end
    end
    end