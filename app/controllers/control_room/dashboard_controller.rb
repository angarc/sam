module ControlRoom
  class DashboardController < ControlRoom::ApplicationController

    def hitlists
      @blogs = current_user.blogs.includes(:posts)
    end
    
  end
end