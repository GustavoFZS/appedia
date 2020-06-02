# frozen_string_literal: true

require 'rails_helper'

describe 'find tag route', type: :request do

  before(:each) do
    user = FactoryBot.create(:user_with_tags, tags_count: 1)
    post '/api/v1/login/signin', params: {
      password: user.password,
      email: user.email
    }
    @tag_id = user.tags.first.id
  end

  before { get "/api/v1/tags/#{@tag_id}" }

  it 'returns status code 200' do
    expect(response).to have_http_status(:success)
  end
end
