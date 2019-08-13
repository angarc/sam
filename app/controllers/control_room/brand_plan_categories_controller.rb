class ControlRoom::BrandPlanCategoriesController < ControlRoom::ElementsController

  def element_model
    BrandPlanCategory
  end

  def new
    @item = element_model.new
    @blog = current_user.blogs.friendly.find(params[:blog_id])
  end

end