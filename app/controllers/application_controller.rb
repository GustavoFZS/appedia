# frozen_string_literal: true

class ApplicationController < ActionController::API
  extend ApiAnnotation::General
  api_annotations!

  before_action :permit_params
  before_action :check_params

  def check_params
    path = "#{self.class.name}/#{action_name}"
    annotation_result = ApiAnnotation::Params.clean_params(path, params.to_h)
    return unless annotation_result

    missing_params = annotation_result[:missing_params]

    if missing_params.length > 0
      response = ApiResponse.new
      response.message = I18n.t('api.missing_params', params: missing_params.join(','))
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
end
