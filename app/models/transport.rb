class Transport < ApplicationRecord
  belongs_to :place
  validates :type_of_transport, :start_date, :end_date, :start_location, presence: true
  validates :end_date, presence: true, date: { after_or_equal_to: :start_date }
  validate :dates_within_place_dates

  before_save :set_date_to_midnight

  private

  def dates_within_place_dates
    ::DatesRangeValidatorService.new(object: self, kind: :place).call
  end

  def set_date_to_midnight
    ::SetDateService.new(self).call
  end
end
