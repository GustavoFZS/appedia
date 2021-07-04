# frozen_string_literal: true

require 'rails_helper'

describe 'find tag route', type: :request do
  before(:each) do
    user = FactoryBot.create(:user_with_tags, tags_count: 1)
    auth(user)
    @tag = user.tags.first
  end

  before { get "/api/v1/tags/#{@tag.id}" }

  it 'returns status code 200' do
    expect(response).to have_http_status(:success)
  end

  it 'check format' do
    expected = TagHelper.tag_format(true, 'Tag encontada com sucesso', @tag)
    response_match(response, expected)
  end
end
