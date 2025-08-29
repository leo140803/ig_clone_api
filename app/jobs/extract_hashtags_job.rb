# app/jobs/extract_hashtags_job.rb
class ExtractHashtagsJob < ApplicationJob
    queue_as :default
  
    def perform(post_id)
      post = Post.find_by(id: post_id)
      return unless post
  
      # cari hashtag di caption
      hashtags = post.caption.to_s.scan(/#\w+/).map { |t| t.delete('#').downcase }.uniq
  
      # simpan ke table tags (misal pakai join table post_tags)
      hashtags.each do |tag_name|
        tag = Tag.find_or_create_by!(name: tag_name)
        PostTag.find_or_create_by!(post: post, tag: tag)
      end
    end
  end
  