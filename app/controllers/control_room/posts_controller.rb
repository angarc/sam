class ControlRoom::PostsController < ControlRoom::ElementsController

  def element_model
    Post
  end

  def index
    @blog = Blog.friendly.find(params[:blog_id])
    @items = @blog.posts
  end

  def new
    super
    @blog = Blog.friendly.find(params[:blog_id])
  end

end