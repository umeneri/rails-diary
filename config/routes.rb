Rails.application.routes.draw do
  resources :diaries do
    collection do
      post 'find', to: 'diaries#find'
    end
  end
  get 'calendar_index', to: 'diaries#calendar_index'
  get 'calendar', to: 'diaries#calendar'
end
