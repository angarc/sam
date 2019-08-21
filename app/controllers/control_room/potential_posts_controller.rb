class ControlRoom::PotentialPostsController < ControlRoom::ElementsController

  def element_model
    PotentialPost
  end

  def index
    @blog = current_user.blogs.friendly.find(params[:blog_id])
    @items = @blog.potential_posts
  end

  def filter
    @blog = current_user.blogs.friendly.find(params[:blog_id])
    @items = @blog.potential_posts

    begin
      if !(params[:competition].empty?) && !(params[:competition] == 'No Filter')
        @items = @items.by_competition(params[:competition].titleize.gsub(' ', '').underscore)
      end
  
      if !(params[:will_create].empty?) && !(params[:will_create] == 'No Filter')
        @items = @items.by_will_create(params[:will_create].titleize.gsub(' ', '').underscore)
      end
    rescue => exception
      puts "FILTER ERROR: Potential Posts #{exception}"  
    end

    render partial: 'control_room/stimulus/quick_element', locals: { items: @items }
  end

  def new
    super
    @blog = current_user.blogs.friendly.find(params[:blog_id])
  end

  def create
    @item = current_user.blogs.friendly.find(params[:blog_id]).potential_posts.build(element_params)

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

  def destroy
    if @item.destroy
      respond_to do |format|
        format.html {
          flash[:success] = "Successfully deleted #{element_model.to_s}"
          redirect_to action: "index", controller: element_model.to_s.pluralize.underscore
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
    @blog = current_user.blogs.friendly.find(params[:blog_id])
    @item = @blog.potential_posts.friendly.find(params[:id])
  end

end