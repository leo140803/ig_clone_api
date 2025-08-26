class UserSerializer < ActiveModel::Serializer
    attributes :id, :username, :name, :bio, :website, :avatar_url, :private,
    :followers_count, :following_count, :posts_count, :is_following
    
    
    def followers_count
    object.followers.count
    end
    
    
    def following_count
    object.following.count
    end
    
    
    def posts_count
    object.posts.count
    end
    
    
    def is_following
    return false unless scope.is_a?(User)
    scope.following.exists?(object.id)
    end
    end