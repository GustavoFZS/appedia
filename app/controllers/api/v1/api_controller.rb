# frozen_string_literal: true

module Api
  module V1
    class ApiController < ApplicationController
      extend ApiAnnotation::General
      before_action :authorization, except: %i[signin signup]

      attr_reader :current_user

      def docs
        @map_annotations = ApiAnnotation.annotations.get
        # @controllers = @map_annotations.keys.select { |ann| ann.include?('controller') }

        respond_to do |format|
          format.html { render template: 'apidocs' }
        end
      end

      def authorization
        authorization = request.headers['Authorization']
        header = authorization.split(' ').last if authorization

        decoded = JsonWebToken.decode(header)
        @current_user = User.find(decoded[:user_id])
      rescue JWT::DecodeError
        response = ErrorPresenter.new('', 401)
        render response
      end
    end
  end
end
