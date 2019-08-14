class ControlRoom::PotentialPostsController < ControlRoom::ElementsController

  def element_model
    PotentialPost
  end

  def index
    @items = current_user.blogs.friendly.find(params[:blog_id]).potential_posts
  end

  def new
    super
    @blog = current_user.blogs.friendly.find(params[:blog_id])
  end

  def create
    @item = current_user.blogs.friendly.find(params[:blog_id]).potential_posts.build(element_params)

    if @item.save
      flash[:success] = "Successfully created #{element_model.to_s}"
      redirect_to action: "show", id: @item
    else
      flash[:danger] = @item.errors.full_messages.to_sentence
      redirect_to action: "index", controller: element_model.to_s.pluralize.underscore
    end
  end

  protected

  def set_item
    @item = current_user.blogs.friendly.find(params[:blog_id]).potential_posts.friendly.find(params[:id])
  end

end