class AdminController < ApplicationController
  # before_action :authenticate_admin, only: [:dashboard, :update_post, :new_post, :create_post]

  def index
  end

  def dashboard
    @post = Post.order(created_at: :desc).first
  end

  def update_post
    @post = Post.friendly.find(params[:id])
    if @post.update(post_params)
      redirect_to admin_dashboard_path, notice: "Post was successfully updated."
    else
      flash.now[:alert] = "Error updating post: #{@post.errors.full_messages.join(', ')}"
      render :dashboard
    end
  rescue => e
    Rails.logger.error "Error updating post: #{e.message}"
    flash.now[:alert] = "An unexpected error occurred while updating the post."
    @post = Post.order(created_at: :desc).first  # Reload the latest post
    render :dashboard
  end

  def new_post
    @post = Post.new
  end

  def create_post
    @post = Post.new(post_params)
    if @post.save
      redirect_to admin_dashboard_path, notice: "Post was successfully created."
    else
      flash.now[:alert] = "Error creating post: #{@post.errors.full_messages.join(', ')}"
      render :new_post
    end
  rescue => e
    Rails.logger.error "Error creating post: #{e.message}"
    flash.now[:alert] = "An unexpected error occurred while creating the post."
    render :new_post
  end

  private

  def authenticate_admin
    redirect_to admin_path unless session[:admin_email]
  end

  def post_params
    params.require(:post).permit(:title, :content, :category, :author, :published_at, :meta_description, :featured_image, :tags, :reading_time)
  end
end
