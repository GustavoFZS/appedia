# frozen_string_literal: true

require 'rails_helper'

describe 'update tag route', type: :request do

  before(:each) do
    user = FactoryBot.create(:user_with_tags, tags_count: 1)
    @tag = user.tags.first

    post '/api/v1/login/signin', params: {
      password: user.password,
      email: user.email
    }
  end

  before do
    put "/api/v1/tags/#{@tag.id}", params: {
      title: 'titulo teste'
    }
    @tag.title = 'titulo teste'
  end

  it 'returns status code 200' do
    expect(response).to have_http_status(:success)
  end

  it 'validate title' do
    expect(JSON.parse(response.body)['content']['title']).to eq(@tag.title)
  end

  it 'check format' do
    expected = TagHelper.tag_format(true, 'Tag atualizada com sucesso', @tag)
    response_match(response, expected)
  end
end
