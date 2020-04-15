class Exercise < ApplicationRecord
  validates_presence_of :name, :status
  validates_uniqueness_of :name
  before_validation :set_status
  enum status: {
    inactive: 0,
    active: 1
  }
  paginates_per 15

  private

    def set_status
      self.status = :active unless self.status
    end

end
