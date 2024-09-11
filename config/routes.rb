Rails.application.routes.draw do
  root "star_wars#films"
  get "/films", to: "star_wars#films"
  get "/films/:id", to: "star_wars#show_film", as: "film"
  get "/people", to: "star_wars#people"
  get "/people/:id", to: "star_wars#show_person", as: "person"
  get "/vehicles", to: "star_wars#vehicles"
  get "/vehicles/:id", to: "star_wars#show_vehicle", as: "vehicle"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  # Defines the root path route ("/")
  # root "posts#index"
end
