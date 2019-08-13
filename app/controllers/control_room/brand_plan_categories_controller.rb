class ControlRoom::BrandPlanCategoriesController < ControlRoom::ElementsController

  def element_model
    BrandPlanCategory
  end

  def new
    @item = element_model.new
    @blog = Blog.friendly.find(params[:blog_id])
  end

end