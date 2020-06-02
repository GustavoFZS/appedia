# frozen_string_literal: true

class Task < ApplicationRecord
  include Taggable

  belongs_to :user
end
