class PostsController < ApplicationController

  def index
    # find all Post rows
    @posts = Post.all
    # render posts/index view
    render({ :template => "posts/index" })
  end

  def new
    if @current_user
      # render posts/new view, the form for a new Post
      render({ :template => "posts/new" })
    else
      redirect_to("/login")
    end
  end

  def create
    if @current_user
      # start with a new Post
      post = Post.new
      # assign the form's values to the Post's columns
      post["author"] = params["author"]
      post["body"] = params["body"]
      post["image"] = params["image"]
      # save the Post row
      post.save
      # redirect the user
      redirect_to("/posts")
    else
      redirect_to("/login")
    end
  end

end
