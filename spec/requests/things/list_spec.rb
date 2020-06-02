# frozen_string_literal: true

require 'rails_helper'

describe 'list things route', type: :request do

  before(:each) do
    user = FactoryBot.create(:user_with_things, things_count: 10)
    post '/api/v1/login/signin', params: {
      password: user.password,
      email: user.email
    }
  end

  before { get '/api/v1/things' }

  it 'returns all things' do
    expect(JSON.parse(response.body)['items'].size).to eq(10)
  end

  it 'returns status code 200' do
    expect(response).to have_http_status(:success)
  end
end
