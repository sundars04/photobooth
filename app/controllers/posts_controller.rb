class PostsController < ApplicationController
  before_action :find_post, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]
  before_action :require_same_user, only: [:edit, :update, :destroy]

  def index
    @posts = Post.all.order("created_at DESC")
  end

  def show    
  end

  def new
    @post = current_user.posts.build
  end

  def create
    @post= current_user.posts.build(post_params)

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

    def require_same_user
      unless current_user == @post.user
        flash[:danger] = "You can edit or delete only you Pic!"
        redirect_to new_user_session_path
      end
    end
end