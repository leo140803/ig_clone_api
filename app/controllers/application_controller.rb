class ApplicationController < ActionController::API
    include ActionController::Cookies
    
    
    before_action :authenticate_request
    
    
    rescue_from ActiveRecord::RecordNotFound do |e|
    render json: { error: e.message }, status: :not_found
    end
    
    
    private
    
    
    def authenticate_request
    header = request.headers['Authorization']
    token = header.split.last if header.present?
    decoded = JsonWebToken.decode(token)
    @current_user = User.find_by(id: decoded[:user_id]) if decoded
    render json: { error: 'Unauthorized' }, status: :unauthorized unless @current_user
    end
    
    
    def current_user
    @current_user
    end
    end