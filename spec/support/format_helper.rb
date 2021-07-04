class FormatHelper
  def self.response(success, message, content = {})
    {
      success: success,
      message: message,
      result: content
    }
  end
end
