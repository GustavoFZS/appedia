# frozen_string_literal: true

class TagPresenter < JsonPresenter
  def object_json
    {
      id: @object.id,
      title: @object.title,
      created_at: formatted_date(@object.created_at),
      things_count: @object.things.count
    }
  end
end
