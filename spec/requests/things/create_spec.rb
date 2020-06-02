# frozen_string_literal: true

require 'rails_helper'

describe 'create things route', type: :request do

  before(:each) do
    user = FactoryBot.create(:user)
    user_tags = FactoryBot.create(:user_with_tags, tags_count: 1)
    @tag_id = user_tags.tags.first.id

    post '/api/v1/login/signin', params: {
      password: user.password,
      email: user.email
    }
  end

  before do
    post '/api/v1/things', params: {
      title: 'Imagem teste',
      content: 'url',
      content_type: 'Image',
      tag_ids: [
        @tag_id
      ]
    }
  end

  it 'returns status code 200' do
    expect(response).to have_http_status(:success)
  end

  it 'validate title' do
    expect(JSON.parse(response.body)['content']['title']).to eq('Imagem teste')
  end
end
