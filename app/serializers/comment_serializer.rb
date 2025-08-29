class CommentSerializer < ActiveModel::Serializer
    attributes :id, :body, :created_at, :like_count
    belongs_to :user, serializer: UserSerializer
    
    
    def like_count
    object.likes.count
    end
    end