# frozen_string_literal: true

require 'rails_helper'

describe 'find tag route', type: :request do

  before(:each) do
    user = FactoryBot.create(:user_with_tags, tags_count: 1)
    @tag_id = user.tags.first.id

    post '/api/v1/login/signin', params: {
      password: user.password,
      email: user.email
    }
  end

  before do
    put "/api/v1/tags/#{@tag_id}", params: {
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
