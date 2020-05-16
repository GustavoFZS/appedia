# frozen_string_literal: true

Rails.application.routes.draw do
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
    end
  end
end
