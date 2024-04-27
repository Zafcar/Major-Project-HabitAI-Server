Rails.application.routes.draw do
  devise_for :users, skip: %i[session], defaults: { format: :json }

  jsonapi_resources :tasks
  jsonapi_resources :sub_tasks do
    collection do
      post :mark_complete
      post :mark_incomplete
    end
  end
  jsonapi_resources :streaks, only: %i[index]
end
