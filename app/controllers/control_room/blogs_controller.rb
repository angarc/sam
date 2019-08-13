class ControlRoom::BlogsController < ControlRoom::ElementsController

  def element_model
    Blog
  end

  def index
    @items = current_user.blogs
  end

  def show
    super
    @posts = @item.posts.order_of_priority
  end

  def create
    @item = element_model.new element_params
    current_user.blogs << @item

    if @item.save
      flash[:success] = "Successfully created #{element_model.to_s}"
      redirect_to action: "show", id: @item
    else
      flash[:danger] = @item.errors.full_messages.to_sentence
      redirect_to action: "index", controller: element_model.to_s.pluralize.underscore
    end
  end

  def statistics
    @item = current_user.blogs.friendly.find(params[:id])
    @posts = @item.posts
    @writing_hours_left = @item.writing_hours_left_on_hit_list
    @words_left = @item.total_num_words_left_to_be_written
    @brand_plan_categories_count = @item.num_potential_posts
  end

  def settings
    @item = current_user.blogs.friendly.find(params[:blog_id])
    @spreadsheet = BlogSpreadsheetImport.new
  end

  def process_spreadsheet
    @item = current_user.blogs.friendly.find(params[:id])
    @spreadsheet = BlogSpreadsheetImport.new spreadsheet_params
    if @spreadsheet.save 
      @item.blog_spreadsheet_imports << @spreadsheet
      
      flash[:success] = "We've placed your excel sheet in a queue. Please give it a minute or two to process all of your data"
      redirect_to control_room_blog_path(id: @item.id)
    else
      flash[:danger] = @spreadsheet.errors.full_messages.to_sentence
      render :settings
    end 
  end

  protected

  def spreadsheet_params
    params.require(:blog_spreadsheet_import).permit(:blog_id, :spreadsheet)
  end

  def set_item
    @item = current_user.blogs.friendly.find(params[:id])
  end

end