class ControlRoom::ElementsController < ControlRoom::ApplicationController
  helper_method :element_model
  before_action :set_item_name, only: [:show, :index, :new, :edit]
  # before_action :authorize_cms_user

  def index
    @items = element_model.all
  end

  def new
    @item = element_model.new
  end

  def create
    @item = element_model.new element_params

    if @item.save
      flash[:success] = "Successfully created #{element_model.to_s}"
      redirect_to action: "show", id: @item
    else
      flash[:danger] = @item.errors.full_messages.to_sentence
      redirect_to action: "index", controller: element_model.to_s.pluralize.underscore
    end
  end

  def edit
    @item = element_model.friendly.find(params[:id])
  end

  def update
    @item = element_model.friendly.find(params[:id])

    if @item.update element_params
      flash[:success] = "Successfully updated #{element_model.to_s}"
      redirect_to action: "show", id: @item
    else
      flash[:danger] = @item.errors.full_messages.to_sentence
      redirect_to action: "index", controller: element_model.to_s.pluralize.underscore
    end
  end

  def show
    @item = element_model.friendly.find(params[:id])
  end

  def destroy
    @item = element_model.friendly.find(params[:id])

    if @item.destroy
      flash[:success] = "Successfully deleted #{element_model.to_s}"
      redirect_to action: "index", controller: element_model.to_s.pluralize.underscore
    else
      flash[:danger] = @item.errors.full_messages.to_sentence
      redirect_to action: "index", controller: element_model.to_s.pluralize.underscore
    end
  end

  def toggle_status
    @item = element_model.friendly.find(params[:id])
    @item.toggle_status
    redirect_back(fallback_location: control_room_path)
  end

  def increment_pos
    @item = element_model.friendly.find(params[:id])
    @item.move_higher
    redirect_back(fallback_location: control_room_path)
  end

  def decrement_pos
    @item = element_model.friendly.find(params[:id])
    @item.move_lower
    redirect_back(fallback_location: control_room_path)
  end

  private

  def authorize_cms_user
    section = ControlRoom::Section.find_by_controller(controller_name)
    unless current_cms_user.sections.include?(section) || current_cms_user.administrator?
      flash[:danger] = "You do not have access to the #{controller_name.pluralize}.
                        Please contact an administrator if you need help."
      redirect_to control_room_path
    end
  end

  def element_params 
    params.require("#{element_model.to_s.underscore}").permit!
  end

  def set_item_name
    @item_name = element_model.to_s
  end
end