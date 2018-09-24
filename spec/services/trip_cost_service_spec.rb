require 'rails_helper'

RSpec.describe TripCostService, type: :service do
  let(:trip) { create(:trip) }
  let(:place) { create(:place, trip_id: trip.id) }
  let(:hotel) { create(:hotel, place_id: place.id) }
  subject { described_class.new(trip) }

  it 'sums the cost of the trip' do
    expect(subject.call).to eq(trip.places.map { |place| place.cost }.sum)
  end
end
