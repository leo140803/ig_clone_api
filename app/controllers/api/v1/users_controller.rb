module Api
    module V1
    class UsersController < ApplicationController
    def me
        render json: current_user, serializer: UserSerializer
    end
    
    
    def show
    user = User.find_by!(username: params[:username])
    render json: user, serializer: UserSerializer
    end
    
    
    def update
        if current_user.update(user_update_params)
          render json: current_user, serializer: UserSerializer
        else
          render json: { errors: current_user.errors.full_messages }, status: :unprocessable_entity
        end
      end
      
    
    
    def search
    users = User.search(params[:q].to_s).order(:username).page(params[:page])
    render json: users, each_serializer: UserSerializer, meta: pagination_meta(users)
    end
    
    
    private
    
    
    def user_update_params
    params.require(:user).permit(:name, :bio, :website, :private, :avatar)
    end
    
    
    def pagination_meta(collection)
    { page: collection.current_page, total_pages: collection.total_pages, count: collection.size }
    end
    end
    end
    end