class StaticContent < ApplicationRecord
  CATEGORIES = %w[droits resources].freeze

  validates :category, presence: true, inclusion: { in: CATEGORIES }
  validates :slug, presence: true, uniqueness: { scope: :category }
  validates :title, presence: true
  validates :description, presence: true

  scope :by_category, ->(category) { where(category: category) }
  scope :by_tags, ->(tags) { where('tags && ARRAY[?]::varchar[]', Array(tags)) if tags.present? }
  scope :ordered, -> { order(position: :asc, created_at: :desc) }

  def tag_list
    tags.join(', ')
  end

  def tag_list=(value)
    self.tags = value.split(',').map(&:strip)
  end
end
