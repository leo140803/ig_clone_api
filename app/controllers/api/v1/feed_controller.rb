module Api
    module V1
    class FeedController < ApplicationController
    def index
    posts = FeedService.new(user: current_user).call.page(params[:page])
    render json: posts, each_serializer: PostSerializer, meta: { page: posts.current_page, total_pages: posts.total_pages }, scope: current_user
    end
    end
    end
    end