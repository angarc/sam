class ControlRoom::PostsController < ControlRoom::ElementsController

  def element_model
    Post
  end

  def index
    @blog = Blog.friendly.find(params[:blog_id])
    @items = @blog.posts.page(params[:page]).per(20)
  end

  def new
    super
    @blog = Blog.friendly.find(params[:blog_id])
  end

end