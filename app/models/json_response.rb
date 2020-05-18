# frozen_string_literal: true

class JsonResponse < Response
  attr_accessor :model
  attr_accessor :message
  attr_accessor :content
  attr_accessor :status_code

  def initialize(model, content)
    @model = model
    @status_code = content.nil? ? 404 : 200
    @content = content
  end

  def to_render
    { json: { success: success?, message: @message, content: Response.json_map(model, content) }, status: @status_code }
  end
end
