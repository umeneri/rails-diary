Rails.application.routes.draw do
  resources :characters do
    collection do
      post 'find', to: 'characters#find'
      post 'diaries', to: 'diaries#find_by_character'
    end
  end

  resources :diaries do
    collection do
      post 'find', to: 'diaries#find'
    end
  end
  get 'calendar_index', to: 'diaries#calendar_index'
  get 'calendar', to: 'diaries#calendar'
end
