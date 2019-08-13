class ControlRoom::BlogsController < ControlRoom::ElementsController

  def element_model
    Blog
  end

  def show
    super
    @posts = @item.posts.order_of_priority
  end

  def statistics
    @item = Blog.friendly.find(params[:id])
    @posts = @item.posts
    @writing_hours_left = @item.writing_hours_left_on_hit_list
    @words_left = @item.total_num_words_left_to_be_written
    @brand_plan_categories_count = @item.num_potential_posts
  end

end