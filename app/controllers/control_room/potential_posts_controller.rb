class ControlRoom::PotentialPostsController < ControlRoom::ElementsController

  def element_model
    PotentialPost
  end

  def new
    super
    @blog = current_user.blogs.friendly.find(params[:blog_id])
  end

end