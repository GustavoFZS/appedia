class FormatHelper
  def self.response(success, message, content = {})
    {
      success: success,
      message: message,
      content: content
    }
  end
end
