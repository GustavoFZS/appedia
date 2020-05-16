class Tag < ApplicationRecord
  has_and_belongs_to_many :things
  belongs_to :user

  validates :title, presence: true, uniqueness: true

  def to_json
    {
      title: title,
      created_at: created_at.strftime('%d/%m/%Y')
    }
  end
end
