require 'rails_helper'

RSpec.describe Hotel, type: :model do
  let(:hotel) { build(:hotel) }

  it 'checks for presence of name' do
    hotel.name = nil
    expect(hotel).not_to be_valid
    expect(hotel.errors[:name][0])
      .to include("can't be blank")
  end

  it 'checks for start date after end date' do
    hotel.end_date = hotel.start_date - 1
    expect(hotel).not_to be_valid
    expect(hotel.errors[:end_date][0])
      .to include("must be after or equal to")
  end

  it 'checks for hotel start date after places' do
    hotel.start_date = hotel.place
      .start_date - 1.day
    expect(hotel).not_to be_valid
    expect(hotel.errors[:start_date][0])
      .to include("can't be earlier than")
    hotel.start_date = hotel.place.start_date
    expect(hotel).to be_valid
  end

  it 'checks for hotel end date before places' do
    hotel.end_date = hotel.place.end_date + 1.day
    expect(hotel).not_to be_valid
    expect(hotel.errors[:end_date][0])
      .to include("can't be later than")
    hotel.end_date = hotel.place.end_date
    expect(hotel).to be_valid
  end

  describe 'sets date to midnight on save' do
    it 'of start_date' do
      previous_start_date = hotel.start_date
      expect { hotel.save }
      .to change {
        hotel.start_date }
        .from(previous_start_date)
        .to(previous_start_date.midnight)
    end

    it 'of end_date' do
      previous_end_date = hotel.end_date
      expect { hotel.save }
      .to change {
        hotel.end_date }
        .from(previous_end_date)
        .to(previous_end_date.midnight)
    end
  end
end
