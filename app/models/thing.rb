class Thing < ApplicationRecord
  include Taggable

  belongs_to :user
end
