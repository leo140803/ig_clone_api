class Post < ApplicationRecord
    belongs_to :user
    has_many :comments, dependent: :destroy
    has_many :likes, as: :likeable, dependent: :destroy
    
    
    has_many_attached :images
    
    
    has_many :post_tags, dependent: :destroy
    has_many :tags, through: :post_tags
    
    
    validates :caption, length: { maximum: 2200 }
    
    
    after_commit :extract_hashtags_async, on: [:create, :update]
    
    
    scope :recent, -> { order(created_at: :desc) }
    
    
    def image_urls
    images.map { |img| Rails.application.routes.url_helpers.url_for(img) }
    end
    
    
    def extract_hashtags_async
    ExtractHashtagsJob.perform_later(id)
    end
    end