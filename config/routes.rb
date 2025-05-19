Rails.application.routes.draw do
  get 'menu/index', to: 'menu#index', as: 'menu'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  devise_for :xx_user_ids
  devise_scope :xx_user_id do
    root to: "xx_user_ids/sessions#new"  # ログイン画面をrootにする例
  end
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check
  # Defines the root path route ("/")
  # root "posts#index"
end
