# frozen_string_literal: true

require 'rails_helper'

describe 'find thing route', type: :request do

  before(:each) do
    user = FactoryBot.create(:user_with_things, things_count: 1)
    auth(user)
    @thing_id = user.things.first.id
  end

  before { get "/api/v1/things/#{@thing_id}" }

  it 'returns status code 200' do
    expect(response).to have_http_status(:success)
  end
end
