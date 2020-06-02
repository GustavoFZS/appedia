# frozen_string_literal: true

require 'rails_helper'

describe 'create tag route', type: :request do

  before(:each) do
    user = FactoryBot.create(:user)
    post '/api/v1/login/signin', params: {
      password: user.password,
      email: user.email
    }
  end

  before do
    post '/api/v1/tags', params: {
      title: 'titulo teste'
    }
  end

  it 'returns status code 200' do
    expect(response).to have_http_status(:success)
  end

  it 'validate title' do
    expect(JSON.parse(response.body)['content']['title']).to eq('titulo teste')
  end
end
