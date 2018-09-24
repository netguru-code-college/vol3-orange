class TripCostService
  def initialize(trip)
    @trip = trip
  end

  def call
    @trip.places.map { |place| place.cost }.sum
  end
end
