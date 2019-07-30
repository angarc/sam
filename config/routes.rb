Rails.application.routes.draw do

  namespace :control_room do
    get '/', to: 'dashboard#index'
  end

end
