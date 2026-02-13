class Contribution < ApplicationRecord
  include Translatable
  has_many_attached :photos
  translates :title, :description

  # Scopes
  scope :published, -> { where(published: true) }
  scope :recent, -> { order(created_at: :desc) }
  scope :by_type, ->(type) { type.present? ? where(contribution_type: type) : all }

  # Geocoding
  geocoded_by :location
  after_validation :geocode, if: :will_save_change_to_location?

  # Validations
  validates :title, presence: true
  validates :description, presence: true
  validates :contribution_type, presence: true
  validates :location, presence: true
  validates :author_name, presence: true

  # Type configuration
  TYPES = %w[fle event enterprise portrait rights].freeze

  TYPE_CONFIG = {
    'fle'        => { emoji: '📚', color: '#3A7A5A', label: 'Cours de FLE' },
    'event'      => { emoji: '🎉', color: '#6A3A9A', label: 'Convivialité' },
    'enterprise' => { emoji: '💼', color: '#1A5B9A', label: 'Entrepreneuriat' },
    'portrait'   => { emoji: '✨', color: '#C45A2A', label: 'Témoignage' },
    'rights'     => { emoji: '📄', color: '#F5A800', label: 'Droits & papiers' }
  }.freeze

  def type_emoji
    TYPE_CONFIG.dig(contribution_type, :emoji) || '🐝'
  end

  def type_color
    TYPE_CONFIG.dig(contribution_type, :color) || '#F5A800'
  end

  def self.type_label(type)
    TYPE_CONFIG.dig(type, :label) || type
  end

  def formatted_date
    created_at&.strftime('%e %b %Y')&.strip
  end

  def main_photo_url
    image_url
  end
end
