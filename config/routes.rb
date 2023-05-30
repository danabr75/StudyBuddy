Rails.application.routes.draw do
  root "decks#index"
  
  devise_for :users
  get 'profile', to: 'profiles#edit'
  patch 'profile', to: 'profiles#update'

  resources :decks do
    resources :cards
    resources :results do
      #resources :card_results
    end
  end

  match '/cards/guess', to: 'cards#guess', via: [:post]
end
