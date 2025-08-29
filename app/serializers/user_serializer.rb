# app/serializers/user_serializer.rb
class UserSerializer < ActiveModel::Serializer
    attributes :id, :username, :name, :bio, :website, :avatar_url, :private,
               :followers_count, :following_count, :posts_count,
               :is_following, :follows_me   # ⬅️ tambah ini
  
    def followers_count
      object.followers.count
    end
  
    def following_count
      object.following.count
    end
  
    def posts_count
      object.posts.count
    end
  
    # apakah current_user (scope) sudah follow 'object' (user yang dilihat)
    def is_following
      return false unless scope.is_a?(User)
      scope.following.exists?(object.id)
    end
  
    # apakah 'object' (user yang dilihat) SUDAH follow current_user
    def follows_me
      return false unless scope.is_a?(User)
      scope.followers.exists?(object.id)
    end
  end
  