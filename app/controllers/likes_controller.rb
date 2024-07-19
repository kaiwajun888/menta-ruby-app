class LikesController < ApplicationController
  before_action :require_login

  def create
    @post = Post.find(params[:post_id])
    current_user.likes.create(post: @post)
    respond_to do |format|
      format.html { redirect_to @post }
      format.turbo_stream
    end
  end

  def destroy
    @post = Like.find(params[:id]).post
    current_user.likes.find_by(post_id: @post.id).destroy
    respond_to do |format|
      format.html { redirect_to @post }
      format.turbo_stream
    end
  end
end
