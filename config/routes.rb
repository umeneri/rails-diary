Rails.application.routes.draw do
  resources :diaries

  get 'calendar', to: 'diaries#calendar'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
