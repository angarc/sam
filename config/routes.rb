Rails.application.routes.draw do
  default_url_options :host => "mysamtool.com"

  devise_for :users
  root 'pages#home'

  namespace :control_room do
  	resources :ideation_and_selection_overviews do
      member do
        post :toggle_status
        post :increment_pos
        post :decrement_pos
      end
    end

    get '/hit-lists', to: 'dashboard#hitlists', as: :hitlists

  	resources :statistic_overviews do
      member do
        post :toggle_status
        post :increment_pos
        post :decrement_pos
      end
    end

    resources :blogs do
      get :settings, to: 'blogs#settings', as: :settings

      member do
        post :toggle_status
        post :increment_pos
        post :decrement_pos
        get 'statistics-overview', to: 'blogs#statistics', as: :statistic_overview
        post :process_spreadsheet, to: 'blogs#process_spreadsheet', as: :process_spreadsheet
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
