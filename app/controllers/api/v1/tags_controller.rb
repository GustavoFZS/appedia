# frozen_string_literal: true

module Api
  module V1
    class TagsController < ApplicationController
      _optional_params(
        {
          title: I18n.t('docs.tag.title'),
          order_by: I18n.t('docs.tag.order_by'),
          order: I18n.t('docs.paginate.order'),
          page: I18n.t('docs.paginate.page'),
          items_per_page: I18n.t('docs.paginate.items_per_page')
        }
      )
      def list
        @query = if @params[:title]
                   user_tags.where('title like ?', "%#{@params[:title]}%")
                 else
                   user_tags.all
                 end

        @response.set_query(@query)
        @query.update_all(last_search: DateTime.now) if @params[:title]

        render
      end

      _required_params(
        {
          id: I18n.t('docs.tag.id')
        }
      )
      def show
        @response.message = if @model
                              i18n_message(:success)
                            else
                              i18n_message(:not_found)
                            end

        render
      end

      _required_params(
        {
          id: I18n.t('docs.tag.id'),
          title: I18n.t('docs.tag.title')
        }
      )
      def update
        if @model.nil?
          @response.message = i18n_message(:not_found)
        elsif @model.update(@params)
          @response.message = i18n_message(:success)
        else
          @response.message = i18n_message(:error)
          @response.status_code = 400
        end

        render
      end

      _required_params(
        {
          title: I18n.t('docs.tag.title')
        }
      )
      def create
        @model.user = current_user

        if @model.save && current_user.save
          @response.message = i18n_message(:success)
        else
          @response.message = i18n_message(:error)
          @response.status_code = 400
        end

        render
      end

      _required_params(
        {
          id: I18n.t('docs.tag.id')
        }
      )
      def delete
        if @model.nil?
          @response.message = i18n_message(:not_found)
        elsif @model.destroy
          @response.message = i18n_message(:success)
        else
          @response.message = i18n_message(:error)
          @response.status_code = 400
        end

        render
      end

      def i18n_message(path, method = action_name)
        I18n.t "api.#{method}.#{path}", model: 'Tag', gender: 'a'
      end
    end
  end
end
