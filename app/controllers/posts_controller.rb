class PostsController < ApplicationController
  def index
    @category = params[:category]
    @posts = Post.where(category: @category)
                 .published
                 .order(published_at: :desc)
                 .limit(20)
  end

  def show
    @category = params[:category]
    @post = Post.friendly.find(params[:slug])

    # Ensure the post matches the category in the URL
    if @post.category != @category
      redirect_to @post.category == "news" ? blog_news_path(@post) : blog_review_path(@post)
    end
  end
end
