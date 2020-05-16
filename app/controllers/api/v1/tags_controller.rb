# frozen_string_literal: true

module Api
  module V1
    class TagsController < ApplicationController
      _optional_params(
        {
          title: I18n.t('docs.tag.title'),
          order_by: I18n.t('docs.tag.order_by'),
          order: I18n.t('docs.tag.order'),
          page: I18n.t('docs.tag.page'),
          items_per_page: I18n.t('docs.tag.items_per_page')
        }
      )
      def list
        response = ArrayResponse.new
        page = @params[:page] ? @params[:page].to_i : 0
        items_per_page = @params[:items_per_page] ? @params[:items_per_page].to_i : 10
        order = @params[:order] ? @params[:order].to_sym : :desc
        order_by = @params[:order_by] ? @params[:order_by].to_sym : :created_at

        tags = if @params[:title]
                 user_tags.where('title like ?', "%#{@params[:title]}%")
               else
                 user_tags.all
               end
        tags = tags.order("#{order_by}": :"#{order}")
        tags = tags.limit(items_per_page).offset(page * items_per_page)

        response.total_items = user_tags.count
        response.current_page = page
        response.items_per_page = items_per_page

        response.add_content(tags.order("#{order_by}": :"#{order}"), &:to_json)

        tags.update_all(last_search: DateTime.now)

        render response.to_render
      end

      _required_params(
        {
          id: I18n.t('docs.tag.id')
        }
      )
      def show
        tag = user_tags.where(id: @params[:id]).first
        response = JsonResponse.new

        if tag
          response.message = i18n_message(:success)
          response.content[:tag] = tag.to_json
        else
          response.message = i18n_message(:not_found)
          response.content[:tag] = nil
          response.status_code = 404
        end

        render response.to_render
      end

      _required_params(
        {
          id: I18n.t('docs.tag.id'),
          title: I18n.t('docs.tag.title')
        }
      )
      def update
        tag = user_tags.where(id: @params[:id]).first
        response = JsonResponse.new

        tag.title = @params[:title]

        if !tag
          response.message = i18n_message(:not_found)
          response.status_code = 404
        elsif tag.save
          response.message = i18n_message(:success)
          response.content[:tag] = tag.to_json
        else
          response.message = i18n_message(:error)
          response.content[:tag] = tag.errors
          response.status_code = 400
        end

        render response.to_render
      end

      _required_params(
        {
          title: I18n.t('docs.tag.title')
        }
      )
      def create
        tag = Tag.new
        response = JsonResponse.new

        tag.title = @params[:title]
        tag.user = current_user

        if !tag
          response.message = i18n_message(:not_found)
          response.status_code = 404
        elsif tag.save && current_user.save
          response.message = i18n_message(:success)
          response.content[:tag] = tag.to_json
        else
          response.message = i18n_message(:error)
          response.content[:tag] = tag.errors
          response.status_code = 400
        end

        render response.to_render
      end

      _required_params(
        {
          id: I18n.t('docs.tag.id')
        }
      )
      def delete
        tag = user_tags.where(id: @params[:id]).first
        response = JsonResponse.new

        if !tag
          response.message = i18n_message(:not_found)
          response.status_code = 404
        elsif tag.destroy
          response.message = i18n_message(:success)
          response.content[:tag] = tag.to_json
        else
          response.message = i18n_message(:error)
          response.content[:erros] = tag.errors
          response.status_code = 400
        end

        render response.to_render
      end

      def user_tags
        current_user.tags
      end
    end
  end
end
