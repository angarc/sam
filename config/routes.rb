Rails.application.routes.draw do

  namespace :control_room do
    get '/hit-lists', to: 'dashboard#hitlists', as: :hitlists

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
        get 'statistics-overview', to: 'blogs#statistics', as: :statistic_overview
      end
      resources :brand_plan_categories do
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
      resources :potential_posts do
        member do
          post :toggle_status
          post :increment_pos
          post :decrement_pos
        end
      end
    end

    get '/', to: 'dashboard#index'
  end

end
