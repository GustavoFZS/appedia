# frozen_string_literal: true

module Taggable
  extend ActiveSupport::Concern

  included do
    has_and_belongs_to_many :tags

    before_save :cache_tags
  end

  def cache_tags
    self.raw_tags = tags.map(&:id).join('|')
  end

  def tag_names
    tags.map(&:title)
  end
end
