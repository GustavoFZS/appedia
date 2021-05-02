# frozen_string_literal: true

require 'rails_helper'

describe 'delete tag route', type: :request do
  before(:each) do
    user = FactoryBot.create(:user_with_tags, tags_count: 1)
    post '/api/v1/login/signin', params: {
      password: user.password,
      email: user.email
    }
    @tag = user.tags.first
  end

  before do
    delete "/api/v1/tags/#{@tag.id}"
  end

  it 'returns status code 200' do
    expect(response).to have_http_status(:success)
  end

  it 'validate tags number' do
    expect(Tag.count).to eq(0)
  end

  it 'check format' do
    expected = TagHelper.tag_format(true, 'Tag deletada com sucesso', @tag)
    response_match(response, expected)
  end
end
