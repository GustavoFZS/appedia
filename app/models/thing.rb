class Thing < ApplicationRecord
  belongs_to :user
  has_and_belongs_to_many :tags

  before_save :add_tags

  def add_tags
    self.raw_tags = tags.map(&:id).join('|')
  end
end
