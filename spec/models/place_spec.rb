require 'rails_helper'

RSpec.describe Place, type: :model do
  let(:place) { build(:place) }

  it 'checks for presence of name' do
    place.name = nil
    expect(place).not_to be_valid
    expect(place.errors[:name][0])
      .to include("can't be blank")
  end

  it 'checks for start date after end date' do
    place.end_date = place.start_date - 1
    expect(place).not_to be_valid
    expect(place.errors[:end_date][0])
      .to include("must be after or equal to")
  end

  it 'checks for place start date after trips' do
    place.start_date = place.trip.start_date - 1.day
    expect(place).not_to be_valid
    expect(place.errors[:start_date][0])
      .to include("can't be earlier than")
    place.start_date = place.trip.start_date
    expect(place).to be_valid
  end

  it 'checks for place end date before trips' do
    place.end_date = place.trip.end_date + 1
    expect(place).not_to be_valid
    expect(place.errors[:end_date][0])
      .to include("can't be later than")
    place.end_date = place.trip.end_date
    expect(place).to be_valid
  end

  describe 'sets date to midnight on save' do
    it 'of start_date' do
      previous_start_date = place.start_date
      expect { place.save }
      .to change {
        place.start_date }
        .from(previous_start_date)
        .to(previous_start_date.midnight)
    end

    it 'of end_date' do
      previous_end_date = place.end_date
      expect { place.save }
      .to change {
        place.end_date }
        .from(previous_end_date)
        .to(previous_end_date.midnight)
    end
  end
end
