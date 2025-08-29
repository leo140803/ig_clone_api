class FeedService
    def initialize(user:)
    @user = user
    end
    
    
    def call
    Post.where(user_id: (@user.following.select(:id)) OR @user.id)
    .includes(:user, images_attachments: :blob)
    .recent
    end