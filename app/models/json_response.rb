# frozen_string_literal: true

class JsonResponse
  attr_accessor :status_code
  attr_accessor :message
  attr_accessor :content

  def initialize(message = '', content = {}, status_code = 200)
    @status_code = status_code
    @message = message
    @content = content
  end

  def success?
    @status_code >= 200 && @status_code < 300
  end

  def to_render
    { json: { success: success?, message: @message, content: @content }, status: @status_code }
  end
end
