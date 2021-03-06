class Transport < ApplicationRecord
  belongs_to :place
  validates :type_of_transport, :start_time, :end_time, :start_location, presence: true
  validates :end_time, presence: true, date: { after_or_equal_to: :start_time }
  validate :start_time_within_place_dates, :end_time_within_place_dates

  before_save :set_time_to_midnight

  def start_time_within_place_dates
    if place.start_date > start_time
      errors.add(:start_time, "can't be earlier than #{place.start_date}")
    end
  end

  def end_time_within_place_dates
    if place.end_date < end_time
      errors.add(:end_time, "can't be later than #{place.end_date}")
    end
  end

  private

  def set_time_to_midnight
    self.start_time = self.start_time.midnight
    self.end_time = self.end_time.midnight
  end
end
