class Review < ApplicationRecord
  belongs_to :recipe, touch: true

  validates :author_name, presence: true
  validates :rating, presence: true, inclusion: { in: 1..5 }
  validates :comment, presence: true

  after_commit :expire_recipe_cache

  private

  def expire_recipe_cache
    Rails.cache.delete("recipe_count")
  end
end
