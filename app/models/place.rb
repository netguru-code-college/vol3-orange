class Place < ApplicationRecord
  has_many :hotels, dependent: :destroy
  has_many :attractions, dependent: :destroy
  has_many :transports, dependent: :destroy
  belongs_to :trip

  validates :name, :start_date, presence: true
  validates :end_date, presence: true, date: { after_or_equal_to: :start_date }
  validate :dates_within_trip_dates

  geocoded_by :full_address
  after_validation :geocode if :full_address_changed?

  before_save :set_date_to_midnight

  attr_accessor :cost

  def full_address
    [name, country].compact.join(',')
  end

  def cost
    PlaceCostService.new(self).call
  end

  private

  def dates_within_trip_dates
    ::DatesRangeValidatorService.new(object: self, kind: :trip).call
  end

  def set_date_to_midnight
    ::SetDateService.new(self).call
  end
end
