class Api::V1::PostsController < ApplicationController
  respond_to :json
  skip_before_action :verify_authenticity_token

  def index
    respond_with Post.all
  end

  def show
    respond_with Post.find(params[:id])
  end

  def new
    respond_with Post.new
  end

  def create
    @post = Post.create(post_params)
    respond_with :api, :v1, @post
  end

  private

  def post_params
    params.require(:post).permit(:title, :body)
  end

end
