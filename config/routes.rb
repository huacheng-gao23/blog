Rails.application.routes.draw do
  get "sessions/create"
  get "/admin", to: "admin#index"
  get "/admin/dashboard", to: "admin#dashboard", as: :admin_dashboard
  patch "/admin/posts/:id", to: "admin#update_post", as: :admin_update_post
  get 'admin/new_post', to: 'admin#new_post'
  post 'admin/create_post', to: 'admin#create_post'

  resources :subscriptions, only: [:create]


  # Omniauth
  get "/auth/:provider/callback", to: "sessions#create"
  post "/auth/:provider/callback", to: "sessions#create"

  # Root route
  root to: "blog#index"

  # Blog routes
  get "blog", to: "blog#index"

  scope "blog" do
    get "news", to: "posts#index", defaults: { category: "news" }, as: :blog_news
    get "news/:slug", to: "posts#show", defaults: { category: "news" }, as: :blog_news_post
    get "reviews", to: "posts#index", defaults: { category: "review" }, as: :blog_reviews
    get "reviews/:slug", to: "posts#show", defaults: { category: "review" }, as: :blog_review_post
  end

  # Existing routes
  resources :emails
  resources :articles

  # Health check and PWA routes
  get "up" => "rails/health#show", as: :rails_health_check
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
end
