Rails.application.routes.draw do

  namespace :control_room do
  	resources :statistic_overviews do
      member do
        post :toggle_status
        post :increment_pos
        post :decrement_pos
      end
    end

  	resources :posts do
      member do
        post :toggle_status
        post :increment_pos
        post :decrement_pos
      end
    end

  	resources :statistic_overviews do
      member do
        post :toggle_status
        post :increment_pos
        post :decrement_pos
      end
    end

  	resources :blogs do
      member do
        post :toggle_status
        post :increment_pos
        post :decrement_pos
      end
    end

    get '/', to: 'dashboard#index'
  end

end
