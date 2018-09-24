require 'faker'
require 'as-duration'

Rails.logger = Logger.new(STDOUT)

Rails.logger.info "Creating users..."

User.create(
  email: 'user@user.com',
  password: 'Orange2018'
)

Rails.logger.info "Creating trips..."

User.all.each do |user|
  5.times do
    start_date = Faker::Time.between(1.year.ago, 1.year.from_now, :all)
    user.trips.create!(
      name: Faker::Address.country + " trip",
      start_date: start_date,
      end_date: start_date + 2.months
    )
    print "."
  end
end

puts ""

Rails.logger.info "Creating places..."

Trip.all.each do |trip|
  3.times do |i|
    trip.places.create!(
      name: Faker::Address.city,
      country: Faker::Address.country,
      start_date: trip.start_date + i.days + 2.days,
      end_date: trip.end_date - i.days
    )
    print '.'
  end
end

puts ""

Rails.logger.info "Creating hotels/attractions/transports..."

Place.all.each do |place|
  6.times do |i|
    place.hotels.create!(
      name: Faker::Witcher.monster,
      start_date: place.start_date + i.days + 4.days,
      end_date: place.end_date - i.days - 4.days
    )
    place.attractions.create!(
      name: Faker::Restaurant.name,
      start_date: place.start_date + i.days + 1.day,
      end_date: place.end_date - i.days - 1.day
    )
    place.transports.create!(
      type_of_transport: Faker::Dessert.variety,
      start_date: place.start_date + i.days + 3.days,
      end_date: place.end_date - i.days - 3.days,
      start_location: Faker::WorldCup.city
    )
    print "."
  end
end

puts ""
