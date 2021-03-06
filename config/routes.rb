# frozen_string_literal: true

Rails.application.routes.draw do
  mount ApiDocs::Engine => '/apidocs'
  # get 'api_docs' => '/api_docs/apidocs#index'

  devise_for :users
  namespace 'api' do
    get 'docs'
    namespace 'v1' do
      post 'login/signin'
      post 'login/signup'

      get 'tags', to: 'tags#list'
      post 'tags', to: 'tags#create'
      get 'tags/:id', to: 'tags#show'
      put 'tags/:id', to: 'tags#update'
      delete 'tags/:id', to: 'tags#delete'

      get 'things', to: 'things#list'
      post 'things', to: 'things#create'
      get 'things/:id', to: 'things#show'
      put 'things/:id', to: 'things#update'
      delete 'things/:id', to: 'things#delete'
    end
  end
end
