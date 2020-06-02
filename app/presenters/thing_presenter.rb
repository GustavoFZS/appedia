# frozen_string_literal: true

class ThingPresenter < JsonPresenter
  def object_json
    {
      id: @object.id,
      title: @object.title,
      tags: @object.tag_names,
      content: @object.content,
      content_type: @object.content_type,
      created_at: formatted_date(@object.created_at)
    }
  end
end
