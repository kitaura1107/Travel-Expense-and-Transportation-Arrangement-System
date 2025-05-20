Rails.application.routes.draw do
  # デバイス（ログイン）画面ルート
  devise_for :xx_user_ids
  devise_scope :xx_user_id do
    root to: "xx_user_ids/sessions#new"  # ログイン画面をrootにする
  end
  
  # メニュー画面ルート
  get 'menu/index', to: 'menu#index', as: 'menu'
  
  # 旅費手配画面ルート
  get 'travel_requests/new'
  get 'travel_requests/index'
  
  # 社員・タコマスタメンテ画面ルート
  get 'employee_taco_masters/new'
  get 'employee_taco_masters/index'
  
  # 部門マスタメンテ画面ルート
  get 'departments/new'
  get 'departments/index'

  # 集計帳票画面ルート
  get 'reports/index'
  
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check
  # Defines the root path route ("/")
  # root "posts#index"
end
