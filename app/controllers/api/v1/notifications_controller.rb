module Api
    module V1
      class NotificationsController < ApplicationController
        def index
          notifications = current_user.notifications
                                     .includes(:actor, :notifiable)
                                     .order(created_at: :desc)
                                     .page(params[:page])
          
          # Return dengan struktur yang konsisten
          render json: {
            notifications: ActiveModelSerializers::SerializableResource.new(
              notifications, 
              each_serializer: NotificationSerializer
            ).as_json,
            meta: { 
              page: notifications.current_page, 
              total_pages: notifications.total_pages,
              count: notifications.total_count
            }
          }
        end
        
        def mark_read
          notification = current_user.notifications.find(params[:id])
          notification.update(read_at: Time.current)
          head :no_content
        end
      end
    end
  end