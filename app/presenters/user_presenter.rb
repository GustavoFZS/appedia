# frozen_string_literal: true

class UserPresenter < JsonPresenter
  def object_json
    {
      name: @object.name,
      email: @object.email
    }
  end
end
