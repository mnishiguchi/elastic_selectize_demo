Rails.application.routes.draw do

  get "featured_properties/autocomplete" => "featured_properties#autocomplete"
  resources :featured_properties, only: [:index]

  root "featured_properties#index"
end
