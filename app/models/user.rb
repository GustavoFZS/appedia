class User < ApplicationRecord
  devise :database_authenticatable, :registerable

  has_many :tags
  has_many :things

  validates :name, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true
end
