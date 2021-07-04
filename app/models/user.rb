class User < ApplicationRecord
  devise :database_authenticatable, :registerable

  has_many :tags
  has_many :things
end
