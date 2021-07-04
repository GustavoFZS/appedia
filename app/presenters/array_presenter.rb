# frozen_string_literal: true

class ArrayPresenter
  attr_accessor :page, :order, :query, :order_by, :presenter, :query_count, :items_per_page, :additional_info

  def initialize(presenter, page, items_per_page, order, order_by)
    @presenter = presenter
    @page = page ? page.to_i : 0
    @order = order ? order.to_sym : :desc
    @order_by = order_by ? order_by.to_sym : :created_at
    @items_per_page = items_per_page ? items_per_page.to_i : 10
  end

  def next_page
    page + 1 if page < total_pages
  end

  def items
    content = []

    query.each do |item|
      content << presenter.new(item).object_json
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

  def as_json(*)
    {
      json:
      {
        total_pages: total_pages,
        total_items: query_count,
        current_page: page,
        items_per_page: items_per_page,
        next_page: next_page,
        result: items,
        additional_info: additional_info
      }
    }
  end
end
