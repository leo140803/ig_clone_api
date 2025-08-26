class Like < ApplicationRecord
    belongs_to :user
    belongs_to :likeable, polymorphic: true
    
    
    after_commit :notify_recipient, on: :create
    
    
    def notify_recipient
    recipient = case likeable
    when Post then likeable.user
    when Comment then likeable.user
    end
    return if recipient == user
    
    
    Notification.create!(user: recipient, actor: user, action: 'liked', notifiable: likeable)
    end
    end