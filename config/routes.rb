Rails.application.routes.draw do
  get 'search/index'
  get 'search/term'
  get 'search/name'
  get 'search/number'
  get 'search/result'
  get 'search/result_detail'
#  resources :api_managements
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"

  get '/api_managements/api/:id', to: 'api_managements#api', as: 'api'
  get '/api_managements/num_api:/id', to: 'api_managements#num_api', as: 'num_api_api_management'

# 国税庁APIから取得期間でデータ取得する
  resources :api_managements do
    collection do
      post 'diff_api'
    end
  end
end
