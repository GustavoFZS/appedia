# frozen_string_literal: true

class ApiPresenter
  attr_accessor :content
  attr_accessor :status_code

  def initialize(object)
    @object = object
    @status_code = 200
  end

  def success?
    @status_code >= 200 && @status_code < 300
  end

  def formatted_date(date)
    date.nil? ? '' : date.strftime('%d/%m/%Y %H:%M')
  end
end
