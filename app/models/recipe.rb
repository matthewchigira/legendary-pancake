class Recipe < ApplicationRecord
  has_many :ingredients, dependent: :destroy
  has_many :reviews, dependent: :destroy

  accepts_nested_attributes_for :ingredients, reject_if: :all_blank, allow_destroy: true

  validates :name, presence: true
  validates :description, presence: true
  validates :difficulty, presence: true, inclusion: { in: %w[easy medium hard] }
  validates :prep_time_minutes, numericality: { greater_than: 0 }, allow_nil: true
  validates :cook_time_minutes, numericality: { greater_than: 0 }, allow_nil: true
  validates :servings, numericality: { greater_than: 0 }, allow_nil: true

  scope :search, ->(query) { where("name ILIKE :q OR description ILIKE :q", q: "%#{query}%") if query.present? }
  scope :by_difficulty, ->(difficulty) { where(difficulty: difficulty) if difficulty.present? }

  def average_rating
    reviews.average(:rating)&.round(1) || 0
  end

  def total_time_minutes
    (prep_time_minutes || 0) + (cook_time_minutes || 0)
  end
end
