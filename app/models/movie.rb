class Movie < ApplicationRecord
  has_many :bookmarks
  has_many :lists, through: :bookmarks

  validates :title, :overview, presence: true, uniqueness: true

  before_destroy :check_for_bookmarks

  private

  def check_for_bookmarks
    if bookmarks.exists?
      errors.add(:base, "Cannot delete movie with bookmarks")
      throw(:abort)
    end
  end
end
