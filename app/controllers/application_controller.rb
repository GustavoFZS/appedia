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
      response = JsonPresenter.new(nil)
      response.message = I18n.t('api.missing_params', params: missing_params.join(', '))
      response.status_code = 400
      render(response)
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
    @model = formatted_controller_name.constantize.where(id: @params[:id]).first
    @response = presenter_name.new(@model)
  end

  def create_object
    @model = formatted_controller_name.constantize.new(@params)
    @response = presenter_name.new(@model)
  end

  def list_objects
    page = @params[:page]
    order = @params[:order]
    order_by = @params[:order_by]
    items_per_page = @params[:items_per_page]

    @response = ArrayPresenter.new(presenter_name, page, items_per_page, order, order_by)
  end

  def formatted_controller_name
    controller_name.singularize.capitalize
  end

  def presenter_name
    "#{formatted_controller_name}Presenter".constantize
  end

  def render(response = @response)
    super response.as_json
  end
end
