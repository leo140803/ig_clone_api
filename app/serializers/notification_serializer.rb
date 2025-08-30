class NotificationSerializer < ActiveModel::Serializer
    attributes :id, :action, :read, :created_at, :notifiable_type, :notifiable_id, :notifiable_data
    belongs_to :actor, serializer: UserSerializer
    
    def read
      object.read_at.present?
    end
    
    def notifiable_data
      case object.notifiable_type
      when 'Post'
        {
          id: object.notifiable.id,
          image_urls: object.notifiable.image_urls
        }
      when 'Comment'
        {
          id: object.notifiable.post.id,
          image_urls: object.notifiable.post.image_urls
        }
      else
        { id: object.notifiable.id }
      end
    end
  end