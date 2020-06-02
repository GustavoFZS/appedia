# frozen_string_literal: true

require 'rails_helper'

describe 'list tags in order route', type: :request do
  before(:each) do
    user = FactoryBot.create(:user_with_tags, tags_count: 10)
    post '/api/v1/login/signin', params: {
      password: user.password,
      email: user.email
    }
  end

  it 'order and filter search' do
    get '/api/v1/tags?order_by=last_search&order=desc'
    expect(response.status).to eq(200)
    title = JSON.parse(response.body)['items'][9]['title']

    get "/api/v1/tags?title=#{title}"
    expect(response.status).to eq(200)
    expect(JSON.parse(response.body)['items'][0]['title']).to eq(title)

    get '/api/v1/tags?order_by=last_search&order=desc'
    expect(response.status).to eq(200)
    expect(JSON.parse(response.body)['items'][0]['title']).to eq(title)
  end
end
