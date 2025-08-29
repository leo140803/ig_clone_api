class ApplicationController < ActionController::API
    before_action :set_default_url_options
    
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

    def set_default_url_options
        Rails.application.routes.default_url_options[:host] = request.base_url
      end
    
    
    def current_user
    @current_user
    end
    end