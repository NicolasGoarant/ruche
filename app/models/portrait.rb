class Portrait < ApplicationRecord
  include Translatable
  translates :quote, :origin, :tags

  scope :ordered, -> { order(position: :asc) }

  validates :name, presence: true
  validates :quote, presence: true

  def initial
    name&.first&.upcase
  end
end
