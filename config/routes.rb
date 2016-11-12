Rails.application.routes.draw do

  get "weather_readings/autocomplete" => "weather_readings#autocomplete"
  resources :weather_readings, only: [:index]
  resources :weather_stations

  root "weather_readings#index"
end
