module Api
    module V1
    class AuthController < ApplicationController
    skip_before_action :authenticate_request, only: %i[signup login]
    
    
    def signup
    user = User.new(user_params)
    if user.save
    token = JsonWebToken.encode({user_id: user.id})
    render json: { token:, user: UserSerializer.new(user) }
    else
    render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
    end
    end
    
    
    def login
    user = User.find_by('lower(username) = ? OR lower(email) = ?', params[:login].to_s.downcase, params[:login].to_s.downcase)
    if user&.authenticate(params[:password])
    token = JsonWebToken.encode({ user_id: user.id })
    render json: { token:, user: UserSerializer.new(user) }
    else
    render json: { error: 'Invalid credentials' }, status: :unauthorized
    end
    end
    
    
    private
    
    
    def user_params
    params.require(:user).permit(:username, :email, :password, :name)
    end
    end
    end
    end