# frozen_string_literal: true

class ApplicationController < ActionController::API
  extend ApiAnnotation::General
  api_annotations!

  before_action :permit_params
  before_action :check_params
  before_action :find_object, only: %i[show update delete]
  before_action :create_object, only: %i[create]
  before_action :list_objects, only: %i[list]

  def check_params
    path = "#{self.class.name}/#{action_name}"
    annotation_result = ApiAnnotation::Params.clean_params(path, params.to_h)
    return unless annotation_result

    missing_params = annotation_result[:missing_params]

    unless missing_params.empty?
      response = JsonResponse.new
      response.message = I18n.t('api.missing_params', params: missing_params.join(', '))
      response.content[:missing_params] = missing_params
      response.status_code = 400
      render response.to_render
      return
    end

    @params = annotation_result[:params]
  end

  def permit_params
    params.permit!
  end

  def i18n_message(path, namespace = params[:controller], method = action_name)
    I18n.t "#{namespace.gsub('/', '.')}.#{method}.#{path}"
  end

  def user_tags
    current_user.tags
  end

  def user_things
    current_user.things
  end

  def find_object
    name = controller_name.singularize
    @model = name.capitalize.constantize.where(id: @params[:id]).first
    @response = JsonResponse.new(name.to_sym, @model)
  end

  def create_object
    name = controller_name.singularize
    @model = name.capitalize.constantize.new(@params)
    @response = JsonResponse.new(name.to_sym, @model)
  end

  def list_objects
    name = controller_name.singularize
    page = @params[:page]
    order = @params[:order]
    order_by = @params[:order_by]
    items_per_page = @params[:items_per_page]

    @response = ArrayResponse.new(name, page, items_per_page, order, order_by)
  end

  def render(response = @response)
    super response.to_render
  end
end
