class PostsController < ApplicationController
  def index
    @posts = Post.order(created_at: :DESC)
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(params[:post].permit(:title, :content))
    if @post.save
      flash[:notice] = 'Post created successfully'
      redirect_to posts_path
    else
      flash.now[:alert] = 'Post create failed'
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @post = Post.find(params[:id])
  end
end