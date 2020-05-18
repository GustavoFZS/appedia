# frozen_string_literal: true

class Response

  def self.json_map(model, item)
    return nil unless item
    return nil unless item.valid?

    {
      item: send(model, item),
      errors: item.errors
    }
  end

  def success?
    @status_code >= 200 && @status_code < 300
  end

  # TODO: usar inner join e group_by para obter o things_count
  # e fazer uma subquery para a paginacao continuar funcionando
  def self.tag(tag)
    {
      id: tag.id,
      title: tag.title,
      created_at: created_at(tag),
      things_count: tag.things.count
    }
  end

  def self.thing(thing)
    {
      id: thing.id,
      tags: thing.tags.map(&:title),
      title: thing.title,
      content: thing.content,
      created_at: created_at(thing),
      content_type: thing.content_type
    }
  end

  def self.user(user)
    {
      name: user.name,
      email: user.email
    }
  end

  def self.created_at(model)
    model.created_at.strftime('%d/%m/%Y %H:%M')
  end
end
