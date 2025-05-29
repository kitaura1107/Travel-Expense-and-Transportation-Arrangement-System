Rails.application.routes.draw do
  # デバイス（ログイン）画面ルート
  devise_for :xx_user_ids
  devise_scope :xx_user_id do
    root to: "xx_user_ids/sessions#new"  # ログイン画面をrootにする
  end
  
  # Username情報取得ルート
  namespace :xx_user_ids do
    get 'fetch_username', to: 'users#fetch_username'
  end
  

  # メニュー画面ルート
  get 'menu/index', to: 'menu#index', as: 'menu'
  
  # 旅費手配画面ルート
  get 'travel_requests/new', to: 'travel_requests#new', as: 'travel_requests'
  get 'travel_requests/index', to: 'travel_requests#index', as: 'travel_request_index'
  get 'travel_requests/search', to: 'travel_requests#search', as: 'travel_request_search'
  post 'travel_requests/create', to: 'travel_requests#create', as: 'travel_request_create'
  patch 'travel_requests/update', to: 'travel_requests#update', as: 'travel_request_update'
  delete 'travel_requests/:id', to: 'travel_requests#destroy', as: 'travel_request_delete'
  
  # 社員・タコマスタメンテ画面ルート
  get 'employee_taco_masters/new',to: 'employee_taco_masters#new', as: 'employee_taco_masters'
  get 'employee_taco_masters/index', to: 'employee_taco_masters#index', as: 'employee_index'
  post 'employee_taco_masters/create', to: 'employee_taco_masters#create', as: 'employee_create'
  delete 'employee_taco_masters/:id', to: 'employee_taco_masters#destroy', as: 'employee_delete'
  patch 'employee_taco_masters/update', to: 'employee_taco_masters#update', as: 'employee_update'
  # 社員・タコマスタメンテ検索のルート
  get 'employee_tako_masters/search', to: 'employee_taco_masters#search', as: 'search'
  

  # 部門マスタメンテ画面ルート
  get 'departments/new', to: 'departments#new', as: 'departments'
  get 'departments/index', to: 'departments#index', as: 'department_index'
  get 'departments/search', to: 'departments#search', as: 'department_search'
  post 'departments/create', to: 'departments#create', as: 'department_create' 
  patch 'departments/update', to: 'departments#update', as: 'department_update' 
  delete 'departments/:id', to: 'departments#destroy', as: 'department_delete'

  # 集計帳票画面ルート
  get 'reports/index', to: 'reports#index', as: 'reports'

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check
  # Defines the root path route ("/")
  # root "posts#index"
end
