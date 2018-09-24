class PlaceCostService
  def initialize(place)
    @place = place
  end

  def call
    attributes.map { |attr| sum_attr_cost(attr) }.sum
  end

  private

  def attributes
    %I(hotels attractions transports)
  end

  def sum_attr_cost(attr)
    @place.send(attr)&.map { |attr| attr.cost }.sum
  end
end
