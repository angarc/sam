class ControlRoom::PostsController < ControlRoom::ElementsController

  def element_model
    Post
  end

  def index
    @blog = current_user.blogs.friendly.find(params[:blog_id])
    @items = @blog.posts.page(params[:page]).per(20)
  end

  def new
    super
    @blog = current_user.blogs.friendly.find(params[:blog_id])
  end

  protected

  def set_item
    @blog = current_user.blogs.friendly.find(params[:blog_id])
    @item = @blog.posts.friendly.find(params[:id])
  end

end