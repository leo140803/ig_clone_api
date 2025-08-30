class PostNotificationSerializer < ActiveModel::Serializer
    attributes :id, :image_urls
    
    def image_urls
      object.images.map { |img| Rails.application.routes.url_helpers.url_for(img) }
    end
  end