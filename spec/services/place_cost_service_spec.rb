require 'rails_helper'

RSpec.describe PlaceCostService, type: :service do
  let(:place) { create(:place) }
  let(:hotel) { create(:hotel, place_id: place.id) }
  let(:attraction) { create(:attraction, place_id: place.id) }
  let(:transport) { create(:transport, place_id: place.id) }

  it 'sums the cost of the place' do
    expect(place.cost).to eq(
      hotel.cost + attraction.cost + transport.cost
    )
  end
end
