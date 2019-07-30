module ControlRoom
  class ApplicationController < ActionController::Base
    layout 'control_room/application'
    # before_action :authenticate_cms_user!

    protected

    def is_administrator?
      unless current_cms_user.administrator?
        flash[:danger] = 'You are not authorized to perform that action.'
        redirect_back fallback_location: control_room_path
        return false
      end
      true
    end
  end
end