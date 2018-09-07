require 'rails_helper'

RSpec.describe Transport, type: :model do
  let(:transport) { build(:transport) }

  it 'checks for presence of type of transport' do
    transport.type_of_transport = nil
    expect(transport).not_to be_valid
    expect(transport.errors[:type_of_transport][0])
      .to include("can't be blank")
  end

  it 'checks for presence of start location' do
    transport.start_location = nil
    expect(transport).not_to be_valid
    expect(transport.errors[:start_location][0])
      .to include("can't be blank")
  end

  it 'checks for start date after end date' do
    transport.end_date = transport.start_date - 1
    expect(transport).not_to be_valid
    expect(transport.errors[:end_date][0])
      .to include("must be after or equal to")
  end

  it 'checks for transport start date after places' do
    transport.place.start_date = Time.now
    transport.start_date = Time.now - 1.day
    expect(transport).not_to be_valid
    expect(transport.errors[:start_date][0])
      .to include("can't be earlier than")
    transport.start_date = Time.now + 1.day
    expect(transport).to be_valid
  end

  it 'checks for transport end date before than places' do
    transport.place.end_date = Time.now + 1.day
    transport.end_date = Time.now + 2.days
    expect(transport).not_to be_valid
    expect(transport.errors[:end_date][0])
      .to include("can't be later than")
    transport.end_date = Time.now
    expect(transport).to be_valid
  end
end
