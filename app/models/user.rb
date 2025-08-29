class User < ApplicationRecord
    has_secure_password
    
    
    has_many :posts, dependent: :destroy
    has_many :comments, dependent: :destroy
    has_many :likes, dependent: :destroy
    
    
    # follow relations
    has_many :active_follows, class_name: 'Follow', foreign_key: 'follower_id', dependent: :destroy
    has_many :passive_follows, class_name: 'Follow', foreign_key: 'followed_id', dependent: :destroy
    has_many :following, through: :active_follows, source: :followed
    has_many :followers, through: :passive_follows, source: :follower
    
    
    has_many :notifications, dependent: :destroy # received
    
    
    has_one_attached :avatar
    
    
    validates :username, presence: true, uniqueness: { case_sensitive: false }, length: { in: 3..30 }, format: { with: /\A[a-zA-Z0-9_\.]+\z/ }
    validates :email, presence: true, uniqueness: { case_sensitive: false }, format: { with: URI::MailTo::EMAIL_REGEXP }
    
    
    scope :search, ->(q) { where("username ILIKE :q OR name ILIKE :q", q: "%#{q}%") }
    
    
    def avatar_url
        return nil unless avatar.attached?
        Rails.application.routes.url_helpers.url_for(avatar)
    end
end