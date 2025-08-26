class Follow < ApplicationRecord
    belongs_to :follower, class_name: 'User'
    belongs_to :followed, class_name: 'User'
    validate :not_self
    
    
    def not_self
        errors.add(:followed_id, "can't be same as follower") if follower_id == followed_id
    end
end