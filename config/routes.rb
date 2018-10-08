Rails.application.routes.draw do
  resources :diaries do
    collection do
      get 'calendar', to: 'diaries#calendar'
    end
  end
end
