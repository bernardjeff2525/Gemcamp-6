class PostsController < ApplicationController
  require 'csv'

  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_post, only: %i[show edit update destroy]
  before_action :validate_post_owner, only: [:edit, :update, :destroy]

  def index
    @posts = Post.published.includes(:categories, :user)
                 .order(created_at: :DESC)

    respond_to do |format|
      format.html
      format.csv do
        csv_string = CSV.generate do |csv|
          csv << [
            User.human_attribute_name(:email),
            Post.human_attribute_name(:title),
            Post.human_attribute_name(:content),
            Post.human_attribute_name(:categories),
            Post.human_attribute_name(:created_at)
          ]

          @posts.each do |p|
            csv << [
              p.user&.email,
              p.title,
              p.content,
              p.categories.pluck(:name).join(','),
              p.created_at
            ]
          end
        end
        render plain: csv_string
      end
      format.json do
        render json: @posts.as_json
      end
      format.xml { render xml: @posts.as_json }
    end
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user = current_user
    if @post.save
      flash[:notice] = 'Post created successfully'
      redirect_to posts_path
    else
      flash.now[:alert] = 'Post create failed'
      render :new, status: :unprocessable_entity
    end
  end

  def show; end

  def edit; end

  def update
    if @post.update(post_params)
      flash[:notice] = 'Post update successfully'
      redirect_to posts_path
    else
      flash.now[:alert] = 'Post update failed'
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @post.destroy
    flash[:notice] = 'Post destroyed successfully'
    redirect_to posts_path
  end

  def api_news
    api_key = ENV['API_NEWS_KEY']
    url = 'https://newsapi.org/v2/top-headlines'
    params = { 'apiKey': api_key, country: 'ph' }
    response = RestClient.get url, params: params

    response = JSON.parse(response)
    render json: response['articles']

    response['articles'].each do |articles|

    end
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :content, :image, category_ids: [])
  end

  def validate_post_owner
    return if current_user.genre == 'admin'

    unless @post.user == current_user
      flash[:alert] = 'the post not belongs to you'
      redirect_to posts_path
    end
  end
end