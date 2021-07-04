# frozen_string_literal: true

class ErrorPresenter < JsonPresenter
  def initialize(message, status_code = 400)
    @object = nil
    @status_code = status_code
    @message = message
  end
end
