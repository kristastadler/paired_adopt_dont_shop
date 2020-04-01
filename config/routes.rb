Rails.application.routes.draw do
  #welcome
  root 'welcome#index'

  #shelters
  get '/shelters', to: 'shelters#index'
  get '/shelters/new', to: 'shelters#new'
  post '/shelters', to: 'shelters#create'
  get '/shelters/:shelter_id', to: 'shelters#show'
  get '/shelters/:shelter_id/edit', to: 'shelters#edit'
  patch '/shelters/:shelter_id', to: 'shelters#update'
  delete '/shelters/:shelter_id', to: 'shelters#destroy'

  #pets
  get '/pets', to: 'pets#index'
  get '/pets/:pet_id', to: 'pets#show'
  get '/pets/:pet_id/edit', to: 'pets#edit'
  patch '/pets/:pet_id', to: 'pets#update'
  delete '/pets/:pet_id', to: 'pets#destroy'

  #shelter pets
  get '/shelters/:shelter_id/pets', to: 'shelter_pets#index'
  get '/shelters/:shelter_id/pets/new', to: 'shelter_pets#new'
  post '/shelters/:shelter_id/pets', to: 'shelter_pets#create'

  #reviews
  get '/shelters/:shelter_id/reviews/:review_id/edit', to: 'reviews#edit'
  patch '/shelters/:shelter_id/reviews/:review_id', to: 'reviews#update'
  get '/shelters/:shelter_id/reviews/new', to: 'reviews#new'
  post '/shelters/:shelter_id/reviews', to: 'reviews#create'
  delete '/shelters/:shelter_id/reviews/:review_id', to: 'reviews#destroy'

  #favorites
  get '/favorites', to: 'favorites#index'
  patch '/favorites/:pet_id', to: 'favorites#update'
  delete '/favorites', to: 'favorites#destroy'

  #applications
  get '/applications/new', to: 'applications#new'
  post '/applications/:application_id', to: 'applications#update'
  post '/applications', to: 'applications#create'
  get '/applications/:application_id', to: 'applications#show'

  #pet applications
  get '/pets/:pet_id/applications', to: 'pet_applications#show'
  patch '/pets/:pet_id/:application_id', to: 'pet_applications#update'

end
