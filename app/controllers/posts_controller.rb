class PostsController < ApplicationController
  before_action :check_logon, except: %w[show]
  before_action :set_forum, only: %w[create new]
  before_action :set_post, only: %w[show edit update destroy]
  before_action :check_access, only: %w[edit update destroy]

  # GET /posts/1
  def show
  end

  # GET /forums/:forum_id/posts/new
  def new
    @post = @forum.posts.new  
  end

# POST /forums/:forum_id/posts
  def create
    @post = @forum.posts.new(post_params)  # Create a new post for the current forum
    if @post.save
      redirect_to @post, notice: "Your post was created."
    else 
      render :new, status: :unprocessable_entity
    end
  end

  def new
    @post = @forum.posts.new  
  end

  # GET /posts/1/edit
  def edit
  end 

  def show    # nothing to do here
  end
  

  # PATCH/PUT /posts/1
  def update
    if @post.update(post_params)
      redirect_to @post, notice: "Your post was updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /posts/1
  def destroy
    @forum = @post.forum # we need to save this, so we can redirect to the forum after the destroy
    @post.destroy
    redirect_to @forum, notice: "Your post was deleted."
  end

  private

  def check_logon
    unless @current_user
      redirect_to forums_path, notice: "You can't add, modify, or delete posts before logon."
    end
  end

  def set_forum
    @forum = Forum.find(params[:forum_id])  # If you check the routes for posts, you see that this is the 
  end                                         # forum parameter

  def set_post
    @post = Post.find(params[:id])
  end

  def check_access
    if @post.user_id != @current_user.id
      redirect_to forums_path, notice: "That's not your post, so you can't change it."
    end
  end

  def post_params   # security check, also known as "strong parameters"
    params[:post][:user_id] = @current_user.id
       # here we have to add a parameter so that the post is associated with the current user
    params.require(:post).permit(:title,:content,:user_id)
  end
end