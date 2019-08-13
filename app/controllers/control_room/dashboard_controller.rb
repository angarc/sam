module ControlRoom
  class DashboardController < ControlRoom::ApplicationController

    def hitlists
      @blogs = Blog.all.includes(:posts)
      
    end
    
  end
end