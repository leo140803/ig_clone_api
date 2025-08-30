class CommentSerializer < ActiveModel::Serializer
    attributes :id, :body, :created_at, :like_count
    belongs_to :user, serializer: UserSerializer
    belongs_to :post, serializer: PostNotificationSerializer # Include post data
    
    def like_count
      object.likes.count
    end
  end