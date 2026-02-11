class Portrait < ApplicationRecord
  validates :name, presence: true
  validates :origin, presence: true
  validates :flag, presence: true
  validates :quote, presence: true

  scope :ordered, -> { order(position: :asc, created_at: :desc) }

  def initial
    name.first.upcase
  end

  def tag_list
    tags.join(', ')
  end

  def tag_list=(value)
    self.tags = value.split(',').map(&:strip)
  end
end
