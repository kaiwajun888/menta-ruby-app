class PostsController < ApplicationController
  before_action :require_login, only: [:new, :create, :edit, :update]
  before_action :set_post, only: [:edit, :update]
  before_action :authorize_user, only: [:edit, :update]

  def index
    @posts = Post.order(created_at: :desc)
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      redirect_to posts_path, notice: '投稿が成功しました'
    else
      render :new
    end
  end

  def show
    @post = Post.find(params[:id])
  end

  def edit
  end

  def update
    if @post.update(post_params)
      redirect_to posts_path, notice: '投稿が更新されました'
    else
      render :edit
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :body)
  end

  def set_post
    @post = Post.find(params[:id])
  end

  def authorize_user
    redirect_to posts_path, alert: '権限がありません' unless @post.user == current_user
  end
end
