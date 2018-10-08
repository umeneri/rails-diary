Rails.application.routes.draw do
  resources :diaries
  get 'calendar_index', to: 'diaries#calendar_index'
  get 'calendar', to: 'diaries#calendar'
end
