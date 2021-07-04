# frozen_string_literal: true

require 'rails_helper'

describe 'signup route', type: :request do
  before do
    post '/api/v1/login/signup', params: {
      password: '123456',
      email: 'teste@gmail.com',
      name: 'teste'
    }
  end

  it 'returns status code 200' do
    expect(response).to have_http_status(:success)
  end

  it 'check format' do
    expected = {
      success: true,
      message: 'Usuário cadastrado com sucesso',
      result: {
        name: 'teste',
        email: 'teste@gmail.com'
      }
    }
    response_match(response, expected)
  end
end
