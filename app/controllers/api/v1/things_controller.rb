# frozen_string_literal: true

module Api
  module V1
    class ThingsController < ApplicationController
      _optional_params(
        {
          content_type: I18n.t('docs.thing.content_type'),
          tag_ids: I18n.t('docs.thing.tag_ids'),
          order_by: I18n.t('docs.paginate.order_by'),
          order: I18n.t('docs.paginate.order'),
          page: I18n.t('docs.paginate.page'),
          items_per_page: I18n.t('docs.paginate.items_per_page')
        }
      )
      def list
        content_type = @params[:content_type]
        tag_ids = @params[:tag_ids]
        @query = user_things
        additional_info = {}

        tags = if tag_ids.nil? || tag_ids.empty?
                 []
               else
                 user_tags.where(id: tag_ids).map(&:id)
               end

        tags.each do |tag|
          @query = @query.where('raw_tags like ?', "%#{tag}%")
        end

        @query = @query.where('content_type = ?', content_type) if content_type
        tags_join = @query.joins(:tags).select('tags.title, tags.id').where('tags.id not in (?)', tag_ids)
        additional_info[:related_tags] = tags_join.map { |u| { title: u.title, id: u.id } }

        @response.set_query(@query)
        @response.additional_info = additional_info

        render
      end

      _required_params(
        {
          id: I18n.t('docs.thing.id')
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
          id: I18n.t('docs.thing.id'),
          title: I18n.t('docs.thing.title'),
          content: I18n.t('docs.thing.content'),
          tag_ids: I18n.t('docs.thing.tag_ids'),
          content_type: I18n.t('docs.thing.content_type')
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
          title: I18n.t('docs.thing.title'),
          content: I18n.t('docs.thing.content'),
          tag_ids: I18n.t('docs.thing.tag_ids'),
          content_type: I18n.t('docs.thing.content_type')
        }
      )
      def create
        @model.user = current_user

        if @model.save
          @response.message = i18n_message(:success)
        else
          @response.message = i18n_message(:error)
          @response.status_code = 400
        end

        render
      end

      _required_params(
        {
          id: I18n.t('docs.thing.id')
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
        I18n.t "api.#{method}.#{path}", model: 'Coisa', gender: 'a'
      end
    end
  end
end
