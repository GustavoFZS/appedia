# frozen_string_literal: true

class ArrayResponse
  attr_accessor :content
  attr_accessor :total_items
  attr_accessor :current_page
  attr_accessor :items_per_page

  def initialize(current_page = 0, content = [])
    @current_page = current_page
    @content = content
  end

  def next_page
    current_page + 1 if current_page < total_pages
  end

  def add_content(items)
    items.each do |item|
      content << yield(item)
    end
  end

  def total_pages
    (total_items / items_per_page.to_f).ceil
  end

  def to_render
    {
      json:
      {
        total_pages: total_pages,
        total_items: total_items,
        current_page: current_page,
        items_per_page: items_per_page,
        next_page: next_page,
        items: content
      }
    }
  end
end
