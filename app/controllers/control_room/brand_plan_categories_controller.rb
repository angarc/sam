class ControlRoom::BrandPlanCategoriesController < ControlRoom::ElementsController

  def element_model
    BrandPlanCategory
  end

  def index
    @blog = current_user.blogs.friendly.find(params[:blog_id])
    @items = @blog.brand_plan_categories
  end

  def new
    @item = element_model.new
    @blog = current_user.blogs.friendly.find(params[:blog_id])
  end


  def create
    @item = current_user.blogs.friendly.find(params[:blog_id]).brand_plan_categories.build element_params

    if @item.save
      respond_to do |format|
        format.html {
          flash[:success] = "Successfully created #{element_model.to_s}"
          redirect_to action: "show", id: @item
        }
        format.js
      end
    else
      flash[:danger] = @item.errors.full_messages.to_sentence
      redirect_to action: "index", controller: element_model.to_s.pluralize.underscore
    end
  end

  protected

  def set_item
    @item = current_user.blogs.friendly.find(params[:blog_id]).brand_plan_categories.friendly.find(params[:id])
  end

end