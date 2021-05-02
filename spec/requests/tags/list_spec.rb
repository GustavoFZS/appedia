# frozen_string_literal: true

require 'rails_helper'

describe 'list tags route', type: :request do
  before(:each) do
    user = FactoryBot.create(:user_with_tags, tags_count: 10)
    post '/api/v1/login/signin', params: {
      password: user.password,
      email: user.email
    }
    @tags = user.tags
  end

  before { get '/api/v1/tags' }

  it 'returns all tags' do
    expect(JSON.parse(response.body)['items'].size).to eq(10)
  end

  it 'returns status code 200' do
    expect(response).to have_http_status(:success)
  end

  it 'check format' do
    expected = {
      total_pages: 1,
      total_items: 10,
      current_page: 0,
      items_per_page: 10,
      next_page: 1,
      items: TagHelper.list_format(@tags),
      additional_info: nil
    }
    response_match(response, expected)
  end
end
