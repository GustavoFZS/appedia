# frozen_string_literal: true

module Api
  module V1
    class LoginController < ApiController
      _required_params({
                         email: I18n.t('docs.user.email'),
                         password: I18n.t('docs.user.password')
                       })
      def signin
        email = @params[:email]
        password = @params[:password]

        user = User.where(email: email).first
        response = UserPresenter.new(user)

        if !user || !user.valid_password?(password)
          response.message = i18n_message(:wrong_pass)
          response.status_code = 400
        elsif user.valid_password?(password)
          add_headers(user)
          response.message = i18n_message(:success)
        end

        render response
      end

      _required_params({
                         name: I18n.t('docs.user.name'),
                         email: I18n.t('docs.user.email'),
                         password: I18n.t('docs.user.password')
                       })
      _request(:user)
      _desc('Cria e loga o usuário.')
      def signup
        user = User.new(@params)

        response = UserPresenter.new(user)
        if user.save
          add_headers(user)
          response.message = i18n_message(:success)
        else
          response.message = i18n_message(:user_dup)
          response.status_code = 400
        end

        render response
      end

      def add_headers(user)
        headers['access_token'] = JsonWebToken.encode(user_id: user.id)
        headers['expires_in'] = JsonWebToken.expires_in
      end
    end
  end
end
