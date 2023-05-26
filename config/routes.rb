Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  root "decks#index"
  resources :decks do
    resources :cards
    resources :results do
      #resources :card_results
    end
  end

  match '/cards/guess', to: 'cards#guess', via: [:post]
end
