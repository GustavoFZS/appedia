class TagHelper
  def self.tag_format(success, message, tag)
    FormatHelper.response(success, message, tag_map(tag))
  end

  def self.list_format(tags)
    tags.map { |tag| tag_map(tag) }
  end

  def self.tag_map(tag)
    {
      id: tag[:id],
      title: tag[:title],
      created_at: tag[:created_at]&.strftime('%d/%m/%Y %H:%M'),
      things_count: 0
    }
  end
end
