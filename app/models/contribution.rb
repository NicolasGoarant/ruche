class Contribution < ApplicationRecord
  TYPES = %w[fle event enterprise portrait].freeze

  has_many_attached :photos

  validates :contribution_type, presence: true, inclusion: { in: TYPES }
  validates :title, presence: true, length: { maximum: 200 }
  validates :description, presence: true
  validates :location, presence: true

  scope :published, -> { where(published: true) }
  scope :by_type, ->(type) { where(contribution_type: type) if type.present? }
  scope :recent, -> { order(created_at: :desc) }

  geocoded_by :location
  after_validation :geocode, if: ->(obj) { obj.location.present? && obj.location_changed? }

  def self.type_label(type)
    {
      'fle' => 'Cours de FLE',
      'event' => 'Événement',
      'enterprise' => 'Entreprise créée',
      'portrait' => 'Témoignage'
    }[type]
  end

  def type_color
    {
      'fle' => '#3A7A5A',
      'event' => '#1A5B9A',
      'enterprise' => '#C45A2A',
      'portrait' => '#6A3A9A'
    }[contribution_type]
  end

  def type_emoji
    {
      'fle' => '📚',
      'event' => '🎉',
      'enterprise' => '🚀',
      'portrait' => '✨'
    }[contribution_type]
  end

  def formatted_date
    created_at.strftime("%d %b %Y")
  end

  def main_photo_url
    if photos.attached? && photos.first.present?
      Rails.application.routes.url_helpers.url_for(photos.first)
    else
      image_url
    end
  end
end
