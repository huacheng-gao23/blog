class BlogController < ApplicationController
  def index
    @recent_posts = Post.published
                        .order(published_at: :desc)
                        .limit(20)
    
    @recent_news = @recent_posts.news
    @recent_reviews = @recent_posts.reviews
  end
end