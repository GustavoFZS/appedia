# frozen_string_literal: true

class ApiController < ActionController::Base
  extend ApiAnnotation::General

  def docs
    respond_to do |format|
      format.html { render html: ApiAnnotation.annotations.to_html.html_safe }
      format.json { render json: ApiAnnotation.annotations.get }
    end
  end
end
