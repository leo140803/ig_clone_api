class NotificationSerializer < ActiveModel::Serializer
    attributes :id, :action, :read, :created_at, :notifiable_type, :notifiable_id
    belongs_to :actor, serializer: UserSerializer
    
    
    def read
    object.read_at.present?
    end
    end