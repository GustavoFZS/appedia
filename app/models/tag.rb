class Tag < ApplicationRecord
  belongs_to :user
  has_and_belongs_to_many :things

  validates :title, presence: true, uniqueness: true
end
