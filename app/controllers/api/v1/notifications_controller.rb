module Api
    module V1
    class NotificationsController < ApplicationController
    def index
    notifications = current_user.notifications.includes(:actor, :notifiable).order(created_at: :desc).page(params[:page])
    render json: notifications, each_serializer: NotificationSerializer, meta: { page: notifications.current_page, total_pages: notifications.total_pages }
    end
    
    
    def mark_read
    notification = current_user.notifications.find(params[:id])
    notification.update(read_at: Time.current)
    head :no_content
    end
    end
    end
    end