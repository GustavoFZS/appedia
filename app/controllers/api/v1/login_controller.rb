# frozen_string_literal: true

module Api
  module V1
    class LoginController < ApplicationController

      _required_params({
                         email: I18n.t('docs.user.email'),
                         password: I18n.t('docs.user.password')
                       })
      def signin
        email = @params[:email]
        password = @params[:password]
        response = JsonResponse.new
        tg = Tag.new
        tg.save
        user = User.where(email: email).first
        if user.valid_password?(password)
          bypass_sign_in(user)
          response.message = i18n_message(:success)
          response.content[:user] = user.to_json
        else
          response.message = i18n_message(:wrong_pass)
          response.status_code = 400
        end

        render
      end

      _required_params({
                         name: I18n.t('docs.user.name'),
                         email: I18n.t('docs.user.email'),
                         password: I18n.t('docs.user.password')
                       })
      def signup
        name = params[:name]
        email = params[:email]
        password = params[:password]
        user = User.new

        user.name = name
        user.email = email
        user.password = password

        if user.save
          bypass_sign_in(user)
          @response = JsonResponse.new(:user, user)
          @response.message = i18n_message(:success)
        else
          @response = JsonResponse.new(:user, user)
          @response.message = i18n_message(:user_dup)
          @response.status_code = 400
        end

        render
      end
    end
  end
end
