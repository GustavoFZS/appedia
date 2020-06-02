# frozen_string_literal: true

require 'rails_helper'

describe 'delete thing route', type: :request do

  before(:each) do
    user = FactoryBot.create(:user_with_things, things_count: 1)
    post '/api/v1/login/signin', params: {
      password: user.password,
      email: user.email
    }
    @thing_id = user.things.first.id
  end

  before do
    delete "/api/v1/things/#{@thing_id}"
  end

  it 'returns status code 200' do
    expect(response).to have_http_status(:success)
  end

  it 'validate tags number' do
    expect(Thing.count).to eq(0)
  end
end
