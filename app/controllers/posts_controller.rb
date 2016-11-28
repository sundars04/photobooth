class PostsController < ApplicationController
  before_action :find_post, only: [:show, :edit, :update, :destroy]
  def index
    @posts = Post.all
  end

  def show    
  end

  def new
    @post = Post.new
  end

  def create
    @post= Post.new(post_params)

    if @post.save
      redirect_to posts_path
      flash[:success] = "Your photo is successfully posted"
    else
      flash.now[:warning] = "Your new Photo couldnt be created"
      render 'new'
    end
  end

  def edit    
  end

  def update
    if @post.update(post_params)
      flash[:success] = "Your Photo is updated successfully"
      redirect_to (@post)
    else
      flash.now[:warning] = "Your Photo couldnt be updated"
      render 'edit'
    end
  end

  def destroy
    @post.destroy
    flash[:danger] = "Your Photo was removed successfully!"
    redirect_to :back
  end

  private
    def find_post
      @post = Post.find(params[:id])
    end

    def post_params
      params.require(:post).permit(:caption, :image)
    end
end
