module Api
    module V1
    class PostsController < ApplicationController
    def index
    posts = Post.includes(:user, images_attachments: :blob).recent.page(params[:page])
    render json: posts, each_serializer: PostSerializer, meta: pagination_meta(posts), scope: current_user
    end
    
    
    def create
    post = current_user.posts.build(post_params)
    if post.save
    attach_images(post)
    render json: post, serializer: PostSerializer, status: :created
    else
    render json: { errors: post.errors.full_messages }, status: :unprocessable_entity
    end
    end
    
    
    def show
    post = Post.find(params[:id])
    render json: post,  serializer: PostSerializer
    end
    
    
    def destroy
    post = current_user.posts.find(params[:id])
    post.destroy
    head :no_content
    end
    
    
    private
    
    
    def post_params
    params.require(:post).permit(:caption, :location)
    end
    
    
    def attach_images(post)
    return unless params[:images].present?
    Array(params[:images]).each { |img| post.images.attach(img) }
    end
    
    
    def pagination_meta(collection)
    { page: collection.current_page, total_pages: collection.total_pages, count: collection.size }
    end
    end
    end
    end