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
    @response = JSON.parse(response.body)
  end

  it 'returns status code 200' do
    expect(response).to have_http_status(:success)
  end

  it 'validate title' do
    expect(@response['content']['title']).to eq('titulo teste')
  end

  it 'check format' do
    expected = {
      success: true,
      message: 'Tag criada com sucesso',
      content: {
        id: @response['content']['id'],
        title: 'titulo teste',
        created_at: @response['content']['created_at'],
        things_count: @response['content']['things_count']
      }
    }
    response_match(response, expected)
  end
end
