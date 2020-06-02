# frozen_string_literal: true

class JsonPresenter < ApiPresenter
  attr_accessor :message

  def as_json(*)
    {
      json: {
        success: success?,
        message: @message,
        content: content
      },
      status: @status_code
    }
  end

  def content
    return nil unless @object
    return @object.errors unless @object.valid?

    object_json
  end
end
