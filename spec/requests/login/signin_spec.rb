# frozen_string_literal: true

require 'rails_helper'

describe 'signin route', type: :request do
  before(:each) do
    @user = FactoryBot.create(:user)
  end

  before do
    post '/api/v1/login/signin', params: {
      password: @user.password,
      email: @user.email
    }
  end

  it 'returns status code 200' do
    expect(response).to have_http_status(:success)
  end

  it 'check format' do
    expected = {
      success: true,
      message: 'Usuário logado',
      content: {
        name: @user.name,
        email: @user.email
      }
    }
    response_match(response, expected)
  end
end
