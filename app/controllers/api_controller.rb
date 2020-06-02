# frozen_string_literal: true

class ApiController < ActionController::Base
  extend ApiAnnotation::General

  def docs
    @map_annotations = ApiAnnotation.annotations.get
    # @controllers = @map_annotations.keys.select { |ann| ann.include?('controller') }

    respond_to do |format|
      format.html { render template: 'apidocs' }
    end
  end
end
