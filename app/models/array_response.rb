# frozen_string_literal: true

class ArrayResponse < Response
  attr_accessor :page
  attr_accessor :model
  attr_accessor :order
  attr_accessor :query
  attr_accessor :order_by
  attr_accessor :query_count
  attr_accessor :items_per_page
  attr_accessor :additional_info

  def initialize(model, page, items_per_page, order, order_by)
    @model = model.to_sym
    @page = page ? page.to_i : 0
    @order = order ? order.to_sym : :desc
    @order_by = order_by ? order_by.to_sym : :created_at
    @items_per_page = items_per_page ? items_per_page.to_i : 10
  end

  def next_page
    page + 1 if page < total_pages
  end

  def content
    content = []

    query.each do |item|
      content << Response.send(model, item)
    end
    content
  end

  def total_pages
    (query_count / items_per_page.to_f).ceil
  end

  def set_query(query)
    @query = query.order("#{order_by}": :"#{order}").limit(items_per_page).offset(page * items_per_page)
    @query_count = query.count unless query_count
  end

  def to_render
    {
      json:
      {
        total_pages: total_pages,
        total_items: query_count,
        current_page: page,
        items_per_page: items_per_page,
        next_page: next_page,
        items: content,
        additional_info: additional_info
      }
    }
  end
end
