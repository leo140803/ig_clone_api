class PostSerializer < ActiveModel::Serializer
    attributes :id, :caption, :location, :created_at,
               :image_urls, :like_count, :comment_count, :liked_by_me, :tags
    belongs_to :user, serializer: UserSerializer
    
    def image_urls
      object.images.map { |img| Rails.application.routes.url_helpers.url_for(img) }
    end
    
    def like_count
      object.likes.count
    end
    
    def comment_count
      object.comments.count
    end
    
    def liked_by_me
      return false unless scope.is_a?(User)
      object.likes.exists?(user_id: scope.id)
    end
    
    def tags
      object.tags.pluck(:name)
    end
  end