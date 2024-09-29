class Blog::NewsController < ApplicationController
  def index
    @news_items = News.order(published_at: :desc)
  end

  def show
    @news_item = News.find(params[:id])
  end
end